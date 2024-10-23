import { bookItem } from '../../../utils/dataInterface';
import { readFile } from '../../../utils/file';
import { listItemBuilder } from './listItemBuilder'
import { promptAction } from '@kit.ArkUI';

@Extend(Span)
function normalText() {
  .fontSize(16)
}

@Extend(Span)
function numRedText() {
  .fontColor(Color.Red).fontSize(16)
}

@Extend(Span)
function numGreenText() {
  .fontColor(Color.Green).fontSize(16)
}

@Component
export struct bookIndex {
  @Consume allData: bookItem[]
  @State searchDate: string = ''
  @State searchError: string = ''
  @Consume todayData: bookItem[]
  @Consume lastMonth: string[]
  @Consume dailyCount: number
  @Consume allIncome: number
  @Consume allOutcome: number

  transformIncomeNumberToString(num: number): string {
    return num == 0 ? num.toString() : `+${num.toString()}`
  }

  build() {
    Navigation() {
      Column() {
        Column({ space: 5 }) {
          Row() {
            Text() {
              Span('最近30天记账').normalText()
              Span(this.dailyCount.toString()).fontSize(24).fontWeight(500)
              Span('次').normalText()
            }
          }.width('100%').margin({ left: 30 })

          Flex({ direction: FlexDirection.RowReverse }) {
            Text() {
              Span('收:').normalText()
              Span(this.transformIncomeNumberToString(this.allIncome)).numRedText()
            }.margin({ left: 40, right: 20 })

            Text() {
              Span('支:').normalText()
              Span(this.allOutcome.toString()).numGreenText()
            }
          }.width('100%')
        }.height('10%').width('100%').margin({ top: 0, bottom: 5 })

        Row({ space: 10 }) {
          TextInput({ placeholder: '日期搜索xxxx-xx-xx', text: this.searchDate })
            .width("50%")
            .height(40)
            .backgroundColor($r('sys.color.comp_background_list_card'))
            .onChange((val: string) => {
              this.searchDate = val
            })
            .showError(this.searchError)
            .onSubmit(() => {
            })
          Button("搜索").width("20%").height(40).onClick(() => {
            // TODO:模糊匹配
            readFile(this.searchDate).then((res) => {
              this.allData = [...res]
              this.allIncome = 0
              this.allOutcome = 0
              for (let item of res) {
                let sum: number = parseFloat(item.sum)
                if (item.type === '支出') {
                  this.allOutcome -= sum
                } else {
                  this.allIncome += sum
                }
              }
            }).catch((rej: bookItem[]) => {
              this.allData = rej
              this.allIncome = 0
              this.allOutcome = 0
            })

          })
          Button('重置').width("20%").height(40).onClick(() => {
            this.searchDate = ''
            this.allData = []
            this.allIncome = 0
            this.allOutcome = 0
            for (let date of this.lastMonth) {
              readFile(date).then((res) => {
                this.allData = [...res, ...this.allData]
                for (let item of res) {
                  let sum: number = parseFloat(item.sum)
                  if (item.type === '支出') {
                    this.allOutcome -= sum
                  } else {
                    this.allIncome += sum
                  }
                }
              })
            }
            promptAction.showToast({
              message: '重置成功',
              bottom: 300
            })
          })
        }
        .margin({
          left: 10,
          top: 0,
          right: 10,
          bottom: 0
        })

        Scroll() {

          List({ space: 12 }) {
            ForEach(this.allData, (item: bookItem) => {
              listItemBuilder({ propItem: item })
            }, (item: bookItem) => item.timeMap)
          }
          .width("93%")
          .height('auto')
          .padding(10)
          .margin({ bottom: 115 })
          .cachedCount(30)

        }
        .height('100%')
      }
    }.title("记账数据").titleMode(NavigationTitleMode.Mini).hideBackButton(true)
  }
}
