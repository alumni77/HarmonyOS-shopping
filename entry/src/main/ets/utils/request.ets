import CommonConstants from '../pages/CommonConstants'
import { http } from '@kit.NetworkKit'
import promptAction from '@ohos.promptAction'
import { BusinessError } from '@ohos.base';


//baseURL接口域名
const BASEURL: string = CommonConstants.BASE_URL
//接口入参数据接口
interface RequestParams {
  url: string
  method?: http.RequestMethod
  data?: Object
  headerContentType?: string
}

//接口请求返回数据类
class ResponseResult {
  code: number //状态码
  message: string //处理信息
  data: Object | null //返回数据

  constructor(code?: number, message?: string, data?: Object | null | undefined) {
    this.code = code ?? 0
    this.message = message ?? ''
    this.data = data ?? null
  }
}


/**
 *
 * @param params:接口请求参数（object类型）
 * {
 *  url :请求连接
 *  method ：请求方法
 *  data ：请求数据
 *  headerContentType ：请求头发送的数据格式
 * }
 * @returns Promise<ResponseResult>
 */
export default function request(params: RequestParams): Promise<ResponseResult> {
  return new Promise(async (resolve: (res: ResponseResult) => void, reject: (res: ResponseResult | string | BusinessError | http.HttpResponse) => void) => {
    //请求头contentType
    let contentType: string = params.headerContentType || 'application/json' //默认提交数据类型为application/json
    //请求数据data
    let requestData: Object | undefined = params.data;
    //application/x-www-form-urlencoded类型参数处理成key&value形式
    if (contentType === 'application/x-www-form-urlencoded') {
      if (typeof params.data === 'object') {
        requestData = Object.entries(requestData as object).reduce((prev: string, cur: Array<Object>) => {
          return (prev && `${prev}&`) + `${cur[0]}=${cur[1]}`
        }, '')
      }
    }

    let httpRequest = http.createHttp();
    httpRequest.request(BASEURL + params.url, {
      method: params.method ?? http.RequestMethod.GET, //默认get方法
      header: {
        'Content-Type': contentType,
      },
      extraData: requestData,
      readTimeout: 30000,
      connectTimeout: 30000
    }, (err: BusinessError, data: http.HttpResponse) => {
      if (!err) {
        //请求成功
        if (data.responseCode === 200) {
          let res: ResponseResult = JSON.parse(`${data.result}`);
          let response = new ResponseResult(res.code, res.message, res.data)
          //状态码code=200表示请求成功,状态码可根据实际接口文档修改
          if (res.code === 200) {
            resolve(response);
          }
          else {
            reject(response);
          }
        }
        //请求失败
        else {
          reject(data)
        }
      }
      // 取消订阅HTTP响应头事件
      httpRequest.off('headersReceive');
      // 当该请求使用完毕时，主动销毁该JavaScript Object。
      httpRequest.destroy();
    })
  })
}
