/**
 * 我的设置页面
 */
import CommonConstants from './CommonConstants'
import DataModel from './DataModel'
import ItemData from './ItemData'
import { photoAccessHelper } from '@kit.MediaLibraryKit'
import { fileIo } from '@kit.CoreFileKit'
import { image } from '@kit.ImageKit'
import promptAction from '@ohos.promptAction'
import router from '@ohos.router'

// @Entry
@Component
export default struct MySetting {
  private phone: number = 0
  @State pic: Resource | image.PixelMap = $r('app.media.phone')

  // 构建设置单元格的函数，接收一个ItemData类型的item作为参数
  @Builder
  settingCell(item: ItemData) {
    Row() {
      Row({ space: CommonConstants.COMMON_SPACE }) {
        // 创建一个有间隔的内嵌行布局
        Image(item.img)
          .width($r('app.float.setting_size'))
          .height($r('app.float.setting_size'))
        Text(item.title)// 显示文本
          .fontSize($r('app.float.normal_text_size'))
      }

      // 如果item的others属性为空，则显示一个图像，否则显示一个开关组件
      if (item.others == null) {
        Image($r('app.media.right_grey'))
          .width($r('app.float.setting_jump_width'))
          .height($r('app.float.setting_jump_height'))
      } else {
        Toggle({ type: ToggleType.Switch, isOn: false })
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width(CommonConstants.FULL_PARENT)
    .padding({
      // 设置内边距
      left: $r('app.float.setting_settingCell_left'),
      right: $r('app.float.setting_settingCell_right')
    })
  }

  build() {

    Scroll() {
      Column({ space: CommonConstants.COMMON_SPACE }) {
        // 创建一个内嵌的列布局
        Column() {
          Text($r('app.string.mainPage_tabTitles_mine'))
            .fontWeight(FontWeight.Medium)
            .fontSize($r('app.float.page_title_text_size'))
            .margin({ top: $r('app.float.mainPage_tabTitles_margin') })
            .padding({ left: $r('app.float.mainPage_tabTitles_padding') })
        }
        .width(CommonConstants.FULL_PARENT)
        .alignItems(HorizontalAlign.Start)

        // 接下来是账户信息的布局
        Row() {
          Image(this.pic)
            .width($r('app.float.setting_phone_size'))
            .height($r('app.float.setting_phone_size'))
            .onClick(() => {
              ActionSheet.show({
                title: '修改头像',
                message: '请选择你要执行的操作',
                autoCancel: true,
                alignment: DialogAlignment.Bottom,
                offset: { dx: 0, dy: 25 },
                confirm: {
                  defaultFocus:true,
                  value: '取消',
                  action:()=>{
                    console.log("选择取消")
                  }
                },
                sheets: [
                  {
                    title: '相机',
                    action: () => {
                      promptAction.showToast({
                        message: '选择相机'
                      })
                    }
                  },
                  {
                    title: '相册',
                    action: () => {
                      promptAction.showToast({
                        message: '选择相册'
                      })
                      // 用户选择一张图片, 程序获取其 URI
                      let picker = new photoAccessHelper.PhotoViewPicker()
                      let options: photoAccessHelper.PhotoSelectOptions = {
                        MIMEType: photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE,
                        maxSelectNumber: 1
                      }
                      // 通过 fileIo 和 ImageSource 对象读取图片文件
                      // 使用解码选项创建 PixelMap 对象来处理图片
                      picker.select(options)
                        .then((value: photoAccessHelper.PhotoSelectResult) => {
                          let uri = value.photoUris[0]
                          let file = fileIo.openSync(uri)
                          let source: image.ImageSource = image.createImageSource(file.fd)
                          let decodingoptions: image.DecodingOptions = {
                            editable: true,
                            desiredPixelFormat: 3
                          }
                          // 将处理后的 PixelMap 存储在 this.pic 中
                          source.createPixelMap(decodingoptions)
                            .then((value: image.PixelMap) => {
                              this.pic = value
                            })
                        })
                    }
                  }
                ]
              })
            })
          Column() {
            Text($r('app.string.setting_phone_name'))
              .fontSize($r('app.float.setting_phone_fontSize'))
            Text(this.phone.toString())
              .fontSize($r('app.float.little_text_size'))
              .margin({ top: $r('app.float.setting_name_margin') })
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ left: $r('app.float.setting_phone_margin') })
        }
        .margin({ top: $r('app.float.setting_phone_margin') })
        .alignItems(VerticalAlign.Center)
        .width(CommonConstants.FULL_PARENT)
        .height($r('app.float.setting_phone_height'))
        .backgroundColor(Color.White)
        .padding({ left: $r('app.float.setting_phone_padding') })
        .borderRadius($r('app.float.setting_phone_borderRadius'))

        // 列表布局组件
        List() {
          ForEach(DataModel.getSettingListData(), (item: ItemData) => {
            // 构建每一个列表项
            ListItem() {
              this.settingCell(item)
            }
            .height($r('app.float.setting_list_height'))
            .onClick(() => {
              promptAction.showToast({
                message: item.title
              })
            })
          })
        }
        .backgroundColor(Color.White)
        .width(CommonConstants.FULL_PARENT)
        .height(CommonConstants.SET_LIST_WIDTH)
        .divider({
          // 设置列表项之间的分割线
          strokeWidth: $r('app.float.setting_list_strokeWidth'),
          color: Color.Grey,
          startMargin: $r('app.float.setting_list_startMargin'),
          endMargin: $r('app.float.setting_list_endMargin')
        })
        .borderRadius($r('app.float.setting_list_borderRadius'))
        .padding({ top: $r('app.float.setting_list_padding'), bottom: $r('app.float.setting_list_padding') })

        Blank()
        // 退出按钮的布局
        Button($r('app.string.setting_button'), { type: ButtonType.Capsule })
          .width(CommonConstants.BUTTON_WIDTH)
          .height($r('app.float.login_button_height'))
          .fontSize($r('app.float.normal_text_size'))
          .fontColor($r('app.color.setting_button_fontColor'))
          .fontWeight(FontWeight.Medium)
          .backgroundColor($r('app.color.setting_button_backgroundColor'))
          .margin({ bottom: $r('app.float.setting_button_bottom') })
          .onClick(() => {
            promptAction.showToast({
              message: '退出成功'
            })
            router.replaceUrl({
              url:'pages/Login'
            })
          })
      }
      .height(CommonConstants.FULL_PARENT)
    }
  }
}