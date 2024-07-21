import request from '../utils/request'
import http from '@ohos.net.http'

class params {
  phone: string = ''
  password: string = ''
}

//获取首页数据
export function PhoneLogin(data: params) {
  return request({
    url: "/login",
    method: http.RequestMethod.POST, //不传默认GET
    data,
    headerContentType: 'application/json' //不传默认application/json
  })
}




