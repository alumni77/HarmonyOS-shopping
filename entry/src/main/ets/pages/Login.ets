import CommonConstants from './CommonConstants'
import router from '@ohos.router'
import { PhoneLogin } from '../api/home'
import promptAction from '@ohos.promptAction'

/**
 * 登录页面
 */
@Entry
@Component
struct Login {
  // 登录的账号
  @State
  phone: string = ''
  // 登录的密码
  @State
  password: string = ''
  //是否显示进度条
  @State
  isShowProgress: Boolean = false
  private timeOutId: number = -1 //控制登录超时时间

  login(): void {
    let uiContext = this.getUIContext()
    let promptAction = uiContext.getPromptAction();
    if (this.phone === '' || this.password === '') {
      promptAction.showToast({
        // 开启一个确认的弹层
        message: $r('app.string.input_empty_tips')
      })
    }
    else {
      this.isShowProgress = true
      if (this.timeOutId === -1) {
        // 设置一个定时器,定时两秒
        this.timeOutId = setTimeout(() => {
          // 1.5s之后执行函数
          this.isShowProgress = false
          this.timeOutId = -1
          PhoneLogin({
            phone: this.phone,
            password: this.password
          }).then(res => {
            console.log(JSON.stringify(res))
            if (res.code === CommonConstants.CODE_SUCCESS) {
              promptAction.showToast({
                message: res.message
              })
              router.replaceUrl({
                url: "pages/Index",
                params: {
                  sendMsg: this.phone
                }
              })
            }
          }).catch((error: Error) => {
            try {
              promptAction.showToast({
                message: error.message
              })
            } catch (error) {
              console.error(`showToast args error code is ${error.code}, message is ${error.message}`)
            }
          })
        }, CommonConstants.LOGIN_DELAY_TIME)
      }
    }
  }

  aboutToDisappear(): void {
    // 取消定时器
    clearTimeout(this.timeOutId)
    this.timeOutId = -1
  }

  @Builder
  imageButton(image: Resource) {
    Button({ type: ButtonType.Circle, stateEffect: true }) { // 圆形的按钮， 并且，按钮按下去开启切换效果
      Image(image)
    }
    .height($r('app.float.other_login_image_size'))
    .width($r('app.float.other_login_image_size'))
    .backgroundColor($r('app.color.background'))

  }

  build() {
    // 登录页面的布局
    Column() {
      // Logo图片
      Image($r('app.media.logo'))
        .width($r('app.float.logo_image_size'))
        .height($r('app.float.logo_image_size'))
        .margin(
          {
            top: $r('app.float.logo_margin_top'),
            bottom: $r('app.float.logo_margin_bottom')
          }
        )

      // 登录标题
      Text($r('app.string.login_page'))
        .fontSize($r('app.float.page_title_text_size'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.title_text_color'))

      // 登录了解更多
      Text($r('app.string.login_more'))
        .fontSize($r('app.float.normal_text_size'))
        .fontColor($r('app.color.login_more_text_color'))
        .margin({ bottom: $r('app.float.login_more_margin_bottom'), top: $r('app.float.login_more_margin_top') })

      // 账号输入框
      TextInput({ placeholder: $r('app.string.phone') })
        .inputStyle()
        .maxLength(CommonConstants.INPUT_phone_LENGTH)
        .type(InputType.Number)
        .onChange((value: string) => {
          this.phone = value
        })
      // 账号输入框下的一条线
      Line().lineStyle()

      // 密码输入框
      TextInput({ placeholder: $r('app.string.password') })
        .inputStyle()
        .maxLength(CommonConstants.INPUT_PASSWORD_LENGTH)
        .type(InputType.Password)
        .onChange((value: string) => {
          this.password = value
        })
      // 密码输入框下的一条线
      Line().lineStyle()

      // 短信提示和忘记密码
      Row() {
        Text($r('app.string.message_login')).blueTextStyle()
          .onClick(() => {
            promptAction.showToast({
              message: $r('app.string.message_login')
            })
          })
        Text($r('app.string.forgot_password')).blueTextStyle()
          .onClick(() => {
            promptAction.showToast({
              message: $r('app.string.forgot_password')
            })
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width(CommonConstants.FULL_PARENT)
      .margin({ top: $r('app.float.forgot_margin_top') })

      // 胶囊形状的登录按钮
      Button($r('app.string.login'), { type: ButtonType.Capsule })
        .width(CommonConstants.BUTTON_WIDTH)
        .height($r('app.float.login_button_height'))
        .fontSize($r('app.float.normal_text_size'))
        .fontWeight(FontWeight.Medium)
        .backgroundColor($r('app.color.login_button_color'))
        .margin({
          top: $r('app.float.login_button_margin_top'),
          bottom: $r('app.float.login_button_margin_bottom')
        })
        .onClick(() => {
          // 登录的事件
          this.login()
        })

      // 注册账号文本
      Text($r('app.string.register_phone'))
        .fontColor($r('app.color.login_blue_text_color'))
        .fontSize($r('app.float.normal_text_size'))
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          promptAction.showToast({
            message: $r('app.string.register_phone')
          })
        })

      if (this.isShowProgress) {
        // 圆圈形状的进度条
        LoadingProgress()
          .color($r('app.color.loading_color'))
          .width($r('app.float.login_progress_size'))
          .height($r('app.float.login_progress_size'))
          .margin({ top: $r('app.float.login_progress_margin_top') })
      }

      Blank()
      // 其他登录方式文本
      Text($r('app.string.other_login_method'))
        .fontColor($r('app.color.other_login_text_color'))
        .fontSize($r('app.float.little_text_size'))
        .fontWeight(FontWeight.Medium)
        .margin({ top: $r('app.float.other_login_margin_top'), bottom: $r('app.float.other_login_margin_bottom') })

      // 三种登录方式
      Row({ space: CommonConstants.LOGIN_METHODS_SPACE }) {
        this.imageButton($r('app.media.login_method1'))
        this.imageButton($r('app.media.login_method2'))
        this.imageButton($r('app.media.login_method3'))
      }
    }
    .backgroundColor($r('app.color.background'))
    .height(CommonConstants.FULL_PARENT)
    .width(CommonConstants.FULL_PARENT)
    .padding({
      left: $r('app.float.page_padding_hor'),
      right: $r('app.float.page_padding_hor'),
      bottom: $r('app.float.login_page_padding_bottom')
    })
  }
}


@Extend(TextInput)
// 输入文本框样式
function inputStyle() {
  .placeholderColor($r('app.color.placeholder_color'))
  .height($r('app.float.login_input_height'))
  .fontSize($r('app.float.big_text_size'))
  .backgroundColor($r('app.color.background'))
  .width(CommonConstants.FULL_PARENT)
  .padding({ left: CommonConstants.INPUT_PADDING_LEFT })
  .margin({ top: $r('app.float.input_margin_top') })
}

// Line组件的自定义样式扩展
@Extend(Line)
function lineStyle() {
  .width(CommonConstants.FULL_PARENT)
  .height($r('app.float.line_height'))
  .backgroundColor($r('app.color.line_color'))
}

// Text组件的蓝色文本样式
@Extend(Text)
function blueTextStyle() {
  .fontColor($r('app.color.login_blue_text_color'))
  .fontSize($r('app.float.small_text_size'))
  .fontWeight(FontWeight.Medium)
}
