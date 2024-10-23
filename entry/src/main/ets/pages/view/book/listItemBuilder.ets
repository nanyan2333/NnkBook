import { bookItem, tagNumMapStr } from "../../../utils/dataInterface"


@Component
export struct listItemBuilder {
  @Prop propItem: bookItem

  build() {
    ListItem() {
      Column({ space: 10 }) { // 添加适当的间距，使内容看起来更加整洁

        Row() {
          Column() {
            if (this.propItem.type === '收入') {
              Text('+' + this.propItem.sum).fontSize(20).fontColor(Color.Red)
            } else {
              Text('-' + this.propItem.sum).fontColor(Color.Green).fontSize(20)
            }
          }.width('30%').alignItems(HorizontalAlign.Center).justifyContent(FlexAlign.Center)

          Column({ space: 10 }) {
            Row({ space: 8 }) {
              Image($rawfile('time.svg')).width(20).height(20)
              Text(this.propItem.timeMap).fontColor($r('app.color.text_secondary'))
                .fontWeight(300)
                .fontSize(16)
            }.justifyContent(FlexAlign.Start)

            Row() {
              GridRow({ columns: 2 }) {
                GridCol() {
                  Row({ space: 4 }) {
                    Image($rawfile('tag.svg')).width(20).height(20)
                    Text(tagNumMapStr(this.propItem.tag)).fontColor($r('app.color.text_secondary'))
                      .fontWeight(300)
                      .fontSize(16)
                  }
                }

                GridCol() {
                  Row({ space: 4 }) {
                    Image($rawfile('recordPoint.svg')).width(20).height(20)
                    Text(this.propItem.type).fontColor($r('app.color.text_secondary'))
                      .fontWeight(300)
                      .fontSize(16)
                  }
                }
              }
            }
          }.width('70%')
        }.height('50%')


        Row({ space: 5 }) {
          Image($rawfile('description.svg')).width(20).height(20)
          Text(this.propItem.description)
            .fontColor($r('app.color.text_secondary'))
            .fontWeight(300)
            .fontSize(16).maxLines(2)
        }.margin({ left: 32 }).width('100%')
      }
    }
    .backgroundColor($r('sys.color.comp_background_list_card')) // 背景颜色
    .borderRadius(25) // 圆角
    .height(150)
  }
}

