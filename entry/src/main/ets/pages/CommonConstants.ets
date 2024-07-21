/**
 * 所有功能的通用常量。
 */
export default class CommonConstants {
  static readonly BASE_URL: string = 'http://×××××××:8888'
  static readonly CODE_SUCCESS: number = 200
  static readonly REQUEST_ERROR: string = '请求失败'
  /**
   * 账号的输入长度。
   */
  static readonly INPUT_phone_LENGTH = 11;
  /**
   * 密码的输入长度。
   */
  static readonly INPUT_PASSWORD_LENGTH = 8;
  /**
   * 输入框的左填充。
   */
  static readonly INPUT_PADDING_LEFT = 0;
  /**
   * 模拟登录的延迟时间。
   */
  static readonly LOGIN_DELAY_TIME = 1500;
  /**
   * 组件的通用间距。
   */
  static readonly COMMON_SPACE = 12;
  /**
   * 首页的标题文本。
   */
  static readonly HOME_TITLE = '首页';
  /**
   * 精选
   */
  static readonly Good_CHOICE = '精选';
  /**
   * 设置页面的标题文本。
   */
  static readonly MINE_TITLE = '我的';
  /**
   * 其他登录方法的间距。
   */
  static readonly LOGIN_METHODS_SPACE = 44;
  /**
   * 组件的宽度或高度覆盖父组件。
   */
  static readonly FULL_PARENT = '100%';
  /**
   * 按钮的宽度。
   */
  static readonly BUTTON_WIDTH = '90%';
  /**
   * 设置列表的宽度。
   */
  static readonly SET_LIST_WIDTH = '42%';
  /**
   * 首页标签索引。
   */
  static readonly HOME_TAB_INDEX = 0;
  /**
   * 精选页标签索引
   */
  static readonly GOOD_CHOICE_INDEX = 1;
  /**
   * 我的设置页面标签索引。
   */
  static readonly MINE_TAB_INDEX = 2;
  // 定义一个用于存储数据的key
  static readonly CART_ITEMS_KEY = 'cartItems';
}
