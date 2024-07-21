import data_preferences from '@ohos.data.preferences';
import common from '@ohos.app.ability.common';

/**
 * 轻量级缓存工具类
 */
const context = getContext(this) as common.UIAbilityContext;
let promise = data_preferences.getPreferences(context, 'mystore');

class PreferencesUtils {


  /**
   *
   * @param name 传入的key
   * @param lhz 存储字段的类型（我这里存储的是string，所以直接写死了）
   * @returns 获取数据字段
   */
  static getPrefer(name:string): String {
    promise.then((res)=>{
      res.get(name,data_preferences.MAX_VALUE_LENGTH)
        .then((data:data_preferences.ValueType)=>{
          console.log("-------"+data.toString())
          return data.toString()
        })
    })
    return ""
  }

  /**
   *
   * @param name 传入的key
   * @param valuer 传入的 value
   * 传入需要储存的字段
   */
  static putPrefer(name:string,valuer:data_preferences.ValueType): void {
    promise.then((res)=>{
      res.put(name,valuer)
    })
  }
}
export default PreferencesUtils;