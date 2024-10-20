
import { bookItem } from '../../../utils/dataInterface';
import { getNowDate, getNowTime, getLastMonthDates } from '../../../utils/time'

@Extend(Text)
function textStyle() {
  .height(60)
  .borderRadius(24)
  .fontSize(16)
  .fontWeight(500)
  .textAlign(TextAlign.Center)
}

@Component
export struct bookIndex {
  @Consume allData: bookItem[]
  @State searchDate: string = ''
  @State searchError: string = ''
  @Consume  todayData: bookItem[]
  @Consume lastMonth: string[]



  build() {
    Navigation() {
      Row({ space: 10 }) {
        TextInput({ placeholder: '输入模糊日期匹配', text: this.searchDate })
          .width("70%")
          .height(40)
          .backgroundColor($r('sys.color.comp_background_list_card'))
          .onChange((val: string) => {
            this.searchDate = val
          })
          .showError(this.searchError)
          .onSubmit(() => {
          })
        Button("搜索").width("20%").height(40).onClick(() => {
        })
      }.padding(10)

      List({ space: 12 }) {
        ForEach(this.allData, (item: bookItem) => {
          ListItem() {
            Column() {
              Text(`时间:${item.timeMap}`).textStyle()
              Text(`类型:${item.type}`).textStyle()
              Text(`总计:${item.sum.toString()}`).textStyle()
              Text(`描述:${item.description}`).textStyle()
            }.padding(5).backgroundColor($r('sys.color.comp_background_list_card')).width('100%')
          }
        }, (item: bookItem) => item.timeMap)
      }
      .width("90%")
    }.title("记账数据").titleMode(NavigationTitleMode.Mini).hideBackButton(true)
  }
}
