// This file is created by egg-ts-helper@1.35.1
// Do not modify this file!!!!!!!!!
/* eslint-disable */

import 'egg';
type AnyClass = new (...args: any[]) => any;
type AnyFunc<T = any> = (...args: any[]) => T;
type CanExportFunc = AnyFunc<Promise<any>> | AnyFunc<IterableIterator<any>>;
type AutoInstanceType<T, U = T extends CanExportFunc ? T : T extends AnyFunc ? ReturnType<T> : T> = U extends AnyClass ? InstanceType<U> : U;
import ExportAdmin = require('../../../app/service/admin');
import ExportAppAssets = require('../../../app/service/appAssets');
import ExportAppLogger = require('../../../app/service/appLogger');
import ExportClient = require('../../../app/service/client');
import ExportCommodity = require('../../../app/service/commodity');
import ExportConfigVersion = require('../../../app/service/configVersion');
import ExportFileExport = require('../../../app/service/fileExport');
import ExportFileUpload = require('../../../app/service/fileUpload');
import ExportImgDescription = require('../../../app/service/imgDescription');
import ExportJwt = require('../../../app/service/jwt');
import ExportKeyChangeRecord = require('../../../app/service/keyChangeRecord');
import ExportLayoutTemplate = require('../../../app/service/layoutTemplate');
import ExportMatchMaterial = require('../../../app/service/matchMaterial');
import ExportPackingUp = require('../../../app/service/packingUp');
import ExportScanMatch = require('../../../app/service/scanMatch');
import ExportUser = require('../../../app/service/user');

declare module 'egg' {
  interface IService {
    admin: AutoInstanceType<typeof ExportAdmin>;
    appAssets: AutoInstanceType<typeof ExportAppAssets>;
    appLogger: AutoInstanceType<typeof ExportAppLogger>;
    client: AutoInstanceType<typeof ExportClient>;
    commodity: AutoInstanceType<typeof ExportCommodity>;
    configVersion: AutoInstanceType<typeof ExportConfigVersion>;
    fileExport: AutoInstanceType<typeof ExportFileExport>;
    fileUpload: AutoInstanceType<typeof ExportFileUpload>;
    imgDescription: AutoInstanceType<typeof ExportImgDescription>;
    jwt: AutoInstanceType<typeof ExportJwt>;
    keyChangeRecord: AutoInstanceType<typeof ExportKeyChangeRecord>;
    layoutTemplate: AutoInstanceType<typeof ExportLayoutTemplate>;
    matchMaterial: AutoInstanceType<typeof ExportMatchMaterial>;
    packingUp: AutoInstanceType<typeof ExportPackingUp>;
    scanMatch: AutoInstanceType<typeof ExportScanMatch>;
    user: AutoInstanceType<typeof ExportUser>;
  }
}
