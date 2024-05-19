#!/usr/bin/env python3

# 执行命令 ：python  git-console-vb-20240416.py -h



import os
import time
import json
import sys
import urllib
import urllib.request

##  ----------参数  开始 -----------------
# 主题值  示例：   OYsq76hkoyGULrIXfKtV3vl8HF21
topic_str = "mbJu29d510eMOkPGvXlH7WIjFg3hANqLCYx"

# 指定开始时间   示例：    2024-03-14-00-00-00
begin_time = "2024-03-14-00-00-00"
# 指定结束时间   示例：    2024-04-14-00-00-00
end_time = "2024-04-14-00-00-00"
# 备注   示例：   2024.01.27代码检查
beizhu = "2024.04.16代码检查"
# 是否自动上报 示例： False  True
auto_upload = False

##  ----------参数  结束 -----------------
# 脚本解释
jiaoben_jieshi ="""
参数： 在 脚本文件  14 到 26 行

格式：
python  git-console-vb-20240416.py

参数示例：
基础命令：  示例：   python  git-console-vb-20240416.py       解释：python 全局环境变量 ,  git-console-vb-20240416.py 脚本路径
参数主题：topic_str:   示例：   OYsq76hkoyGULrIXfKtV3vl8HF   解释： 也就是 事件标识 ，方便查询： topic 值 建议在线密码生成一个随机的    长度 20-50之间 可以大小写数组组合
参数指定开始时间：begin_time:  示例：    2024-03-10-00-00-00           解释： 年-月-日-时-分-秒  开始时间
参数指定开始时间：end_time:    示例：    2024-04-14-00-00-00           解释： 年-月-日-时-分-秒  结束时间
参数备注：beizhu:  示例：   2024.01.27代码检查            解释： 备注，
参数是否自动上报：auto_upload:  示例：   False           解释：   不自动上报



 """

argvs=sys.argv
#查询过去多少天的凌晨0点到现在的代码
tianshu=0
argvs_len=len(argvs)
print(  '参数长度: {0}  '.format(argvs_len) )







# 参数是帮助文档
canshu_is_h = len(argvs)>1 and str(argvs[1])=='-h'







# 退出程序
# sys.exit(1)


print('指定开始时间:',begin_time)
print('指定结束时间:',end_time)



# 参数检查方法 主题值
def canshu_guifan_jiancha_topic():
      global topic_str
      if len(topic_str)<20:
        raise Exception('参数： topic_str   主题值  必须长度大于等于 20 小于等于 50 , 建议在线密码生成一个随机的')
      elif len(topic_str)>50:
        raise Exception('参数： topic_str   主题值  必须长度大于等于 20 小于等于 50 , 建议在线密码生成一个随机的')





# 参数检查方法
def canshu_guifan_jiancha():
        canshu_guifan_jiancha_topic()
        if begin_time=="":
           raise Exception('参数：begin_time   指定开始时间 必须填写 格式 : 年-月-日-时-分-秒')
        if end_time=="":
           raise Exception('参数：end_time    指定结束时间 必须填写 格式 : 年-月-日-时-分-秒')
        if beizhu=="":
           raise Exception('参数：beizhu       备注 必须填写 ')












if canshu_is_h:
  print('帮助文档：')
  print(jiaoben_jieshi)
  #退出程序
  sys.exit(1)
else:
  print('参数检查：')

  try:
   canshu_guifan_jiancha()
  except Exception as e:
    print("参数错误，请查看说明文档。")
    print(jiaoben_jieshi)
    sys.exit(1)














print("查询天数:",tianshu)

localtime = time.localtime(time.time())
print ("本地时间:", localtime)


job_time =time.strftime("%Y-%m-%dT%H:%M:%S%z", time.localtime(time.time()  ))

print ("脚本时间:", job_time)

tianshu_tms = tianshu*24*60*60

begin_time_tuple = time.strptime(begin_time,"%Y-%m-%d-%H-%M-%S")
# 2023-12-25T02:13:42PST+0800
since_time =time.strftime("%Y-%m-%dT00:00:00%z", begin_time_tuple)

end_time_tuple = time.strptime(end_time,"%Y-%m-%d-%H-%M-%S")
# 2023-12-25T02:13:42PST+0800
until_time = time.strftime("%Y-%m-%dT23:59:59%z", end_time_tuple)

# print('time.time()',time.time())
# print('tianshu_tms',tianshu_tms)
print('开始时间:',since_time)
print('截止时间:',until_time)



# 统计天数
tianshu = 0
# 时间差 毫秒数
chazhi_tms =  time.mktime(end_time_tuple) - time.mktime(begin_time_tuple)

# 统计天数
tianshu = round( chazhi_tms/(24*60*60),1)

branch=os.popen("git symbolic-ref --short HEAD").read()[0:-1]


print( '代码分支:', branch )


author=os.popen("git config user.name").read()[0:-1].lower()


print( '当前人员: ', author )





# '''


#仓库地址
fetch_remote_address = os.popen( 'git remote -v  ' ).read().split('\n')[0]

fetch_remote_address= fetch_remote_address.rstrip().split(" ")[0].split("\t")[1]


#cmd1 = 'git log --format=\'%aN\' | sort -u | while read name; do echo -en "$name\t"; git log --author="$name" --pretty=tformat: --numstat | awk \'{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc }\' -; done'
#cmd1 = "git log --format=\'%aN\' | sort -u"
cmd1 = "git log --since="+since_time+" --until="+ until_time+"  --format=%aN "



print('cmd1---------', cmd1)
fd = os.popen(cmd1)

# print('cmd1---------', fd)
# 读取输出
result = fd.read()
# print('result---------', result)
names= result.splitlines(False)


names=set(names)
# print(names)
# print( len(names))


result_dict1 = {  }


def resolve_single(str1,name):
 arr=str(str1).split("\t")
# print( arr[0],arr[1])
 add=0
 subs=0
 if arr[0]=="-":
   add=0
 else:
   add=  int(arr[0])
 if arr[1]=="-":
   subs=0
 else:
   subs=  int(arr[1])
#  print('结果 arr0: {0},arr1: {1}, add:{2} ,subs:{3}。'.format(  arr[0],arr[1],add,subs))
 result_name_obj["add_total"] += add
 result_name_obj["subs_total"] += subs






def xunhuan_dan_ren_jieguo(arr,result_name_obj):
  for item in arr:
    resolve_single(item,result_name_obj)


def has_key(d, key):
    return key in d


def strl30(str1,len=30):
  # return str(str1).center(30)
  return str(str1).ljust(len)
  # return str(str1).rjust(30)



for name in names:
  # name=name.lower()
  # print(name)
  if not has_key(result_dict1,name):
    result_dict1[name]={'add_total': 0,  'subs_total':0,'name':name}
  cmd2="git log --since="+since_time+" --until="+ until_time+"   --author="+name+" --pretty=tformat: --numstat  "
  rs2=os.popen(cmd2)
  result2=rs2.read().splitlines(False)
  # print(len(result2))
  result_name_obj=result_dict1[name]
  xunhuan_dan_ren_jieguo(result2,result_name_obj)


# print("result_dict1",result_dict1)
# print("result_dict1",result_dict1.values())


result_dict1_values = result_dict1.values()
# 升序
result_dict1_values = sorted(result_dict1_values, key=lambda x: x['add_total'])


 # str1 ="origin	http://git.sportxxxr1pub.com/front_web/user-pc-vite.git (fetch)"
 # 分割仓库名字
def compute_cangku_name(str1):
  # split(str1="", num=string.count(str))
  arr= str1.split("/")
  cangku= arr[-1].rstrip().split(" ")[0]
  dot_index =cangku.find('.')
  # print(dot_index)
  print("仓库名字：{}".format(cangku[0:dot_index]))
  cangku_name= cangku[0:dot_index]
  return  cangku_name

# 文件名 拼接

file_hash = "{}-{}-{}".format(author, compute_cangku_name(fetch_remote_address) , job_time.replace(':',"-").replace('T',"-").replace('+',"-"))


print("file_hash:{}".format(file_hash))
#写入文件名字
file_name = "git-console-{}.md".format(file_hash)
# 打开文件
file_open = open(file_name, 'w', encoding='utf-8')


def print_and_write(str1):
  print(str1)
  file_open.write(str1+"\n")


print_and_write('')
print_and_write('')
print_and_write('统计文件名字：'+file_name)
print_and_write('远程仓库地址：'+fetch_remote_address)
print_and_write('统计分支名字：'+branch)
print_and_write('统计事件标识：'+topic_str)
print_and_write('统计完整天数：'+str(tianshu))
print_and_write('统计事件备注：'+beizhu)
print_and_write('统计开始时间：'+since_time)
print_and_write('统计截止时间：'+until_time)
print_and_write('统计执行时间：'+job_time)
print_and_write('统计执行人员：'+author)
print_and_write('是否自动上报：'+ ('是' if auto_upload else "否"))

print_and_write('')
print_and_write('')
strf1='| {0} | {1} | {2} | {3} |'
# print_and_write('人员 \t 增加行数 \t  删除行数 \t 逻辑行数 ' )
print_and_write(strf1.format( strl30('人员',28)  ,strl30('增加行数',26),strl30('删除行数',26),strl30('逻辑行数',26) ))
print_and_write(strf1.format( strl30('----')  ,strl30('----'),strl30('----'),strl30('----') ))

add_total=0
subs_total=0
for obj in result_dict1_values:
  add_total+=obj['add_total']
  subs_total+=obj['subs_total']
  # print_and_write('名字: {0},增加行数: {1}, 删除行数:{2} ,逻辑行数:{3}。'.format( obj['name'],obj['add_total'],obj['subs_total'], obj['add_total']-obj['subs_total']))
  # print_and_write(strf1.format( obj['name'],obj['add_total'],obj['subs_total'], obj['add_total']-obj['subs_total']))
  print_and_write(strf1.format( strl30(obj['name'])  ,strl30(obj['add_total']),strl30(obj['subs_total']),strl30(obj['add_total']-obj['subs_total']) ))
# print_and_write('总计: {0},增加行数: {1}, 删除行数:{2} ,逻辑行数:{3}。'.format(  '所有人',add_total, subs_total, add_total - subs_total ))
# print_and_write(strf1.format(  '所有人',add_total, subs_total, add_total - subs_total ))
# print_and_write(strf1.format(  '所有人',add_total, subs_total, add_total - subs_total ))

print_and_write( strf1.format( strl30('所有人',28)  ,strl30( add_total),strl30(subs_total),strl30( add_total - subs_total) ))

# strl30('')


# 关闭文件
file_open.close()


# 打开文件
file_open_2 = open("git-console-{}.json".format(file_hash), 'w', encoding='utf-8')



# 组长 数据格式化

result_dict_final = {
      "remote_address":fetch_remote_address,
      "branch": branch[0:-1],
      "tianshu": str(tianshu),
      "since_time": since_time,
      "until_time": until_time,
      "topic": topic_str,
      "job_time": job_time,
      "author": author,
      "beizhu":beizhu,
      "data":    result_dict1

                     }

json_str = json.dumps(result_dict_final)
file_open_2.write(json_str)

# 关闭文件
file_open_2.close()






# 上报 后台接口
# shangbao_url= "http://127.0.0.1:7001/open_test/index"


shangbao_url= "http://tool-server.dbsportxxx2li.com/openapi/gitCommitLines/report"

# http://tool-server.dbsportxxx2li.com/openapi/gitCommitLines/report
# 这个接口
# params = urllib.parse.urlencode( result_dict_final)

def shangbao_tongji():
    params =  json_str.encode('utf-8')
    headers = {"Content-type": "application/json" }
    req = urllib.request.Request(shangbao_url, params, headers)
    resp = urllib.request.urlopen(req)
    resp_data = resp.read().decode('utf-8')
    print("上报接口返回状态码：{}".format(resp.getcode()))
    print("上报接口返回数据： " )
    print(resp_data)

#如果自定上报就上报
if auto_upload:
  shangbao_tongji()

