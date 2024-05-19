"use strict";

const Controller = require("egg").Controller;
const fs = require('fs');
const crypto = require('crypto');

class ComponentDocController extends Controller {
    async upload() {
        const ctx = this.ctx;
        try {
            const [file] = ctx.request.files
            const { project } = ctx.request.body

            if (file.mimeType !== 'application/json') throw '请上传 JSON 文件'

            // 获取文件 MD5 值，作为 version
            const buffer = fs.readFileSync(file.filepath)
            const hash = crypto.createHash('md5')
            hash.update(buffer, 'utf8')
            const version = hash.digest('hex')

            const component_name = file.filename.replace(/\.doc\.json$/, '')

            // 查找是否有历史版本
            let componentDocData = await ctx.model.ComponentDoc.findOne({ project, version, name: component_name })

            if (!componentDocData) {
                const saveFileInfo = await this.service.fileUpload.save_file([file])
                if (!saveFileInfo.success) throw saveFileInfo.msg

                // // 获取文档内容
                // const docContent = require(file.filepath)

                componentDocData = {
                    name: component_name,
                    path: saveFileInfo.data[file.filename].save_filepath,
                    project,
                    version,
                }

                componentDocData = await ctx.model.ComponentDoc.create(componentDocData)
            }

            await this.updateComponentKeyBy(componentDocData)

            ctx.api_success_data(componentDocData.version);
        } catch (error) {
            ctx.api_error_msg(error)
        } finally {
            ctx.cleanupRequestFiles(ctx.request.files);
        }
    }

    /**
     * 更新 ComponentKey
     * @param {ComponentDoc} componentDocData
     * @returns 
     */
    async updateComponentKeyBy(componentDocData) {
        const { name, project, version: enable_version, } = componentDocData
        return this.ctx.model.ComponentKey.updateOne(
            { component_name: name, project },
            { name, component_name: name, project, enable_version },
            { upsert: true }
        )
    }

    /**
     * 条件查询
     */
    async findBy() {
        const ctx = this.ctx;
        try {
            const { project, name } = ctx.request.query

            const result = await ctx.model.ComponentDoc.find({ project, name }, null, { sort: { createdAt: -1 } })

            ctx.api_success_data(result);
        } catch (error) {
            ctx.api_error_msg(error)
        }
    }

    /**
     * 组件文档 详情
     */
    async findDetailsByProjectAndVersion() {
        const ctx = this.ctx;
        try {
            const { project, version } = ctx.request.query

            const result = await ctx.model.ComponentDoc.findOne({ project, version })

            const buffer = fs.readFileSync('static' + result.path)

            ctx.api_success_data(JSON.parse(buffer.toString()));
        } catch (error) {
            ctx.api_error_msg(error)
        }
    }
}
module.exports = ComponentDocController;
