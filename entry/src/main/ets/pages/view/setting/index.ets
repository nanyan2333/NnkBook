import { bookItem } from "../../../utils/dataInterface"
import { clearMemory, createFile, deleteFile, readFile } from "../../../utils/file"

import { getNowDate, getNowTime } from "../../../utils/time"
import { showDialog } from '../../../utils/confirmDialog'

@Component
export struct settingIndex {
  @State test: bookItem[] = []
  private fileName: string = 'test'
  @State message: string = ''
  @Consume allData:bookItem[]
  @Consume todayData:bookItem[]
  @Consume dailyCount: number
  @Consume allIncome: number
  @Consume allOutcome: number

  build() {
    Column({ space: 10 }) {
      Row({ space: 180 }) {
        Text('清空缓存').fontSize(20).margin({ left: 20 })
        Image($rawfile('clear.svg')).height(30).width(30)
      }
      .width('90%')
      .height(50)
      .borderRadius(25)
      .backgroundColor($r('sys.color.comp_background_list_card'))

      .onClick(() => {
        showDialog('清除数据', '将要清除你的所有记账数据', () => {
          clearMemory()
          this.allData = []
          this.todayData = []
          this.dailyCount = 0
          this.allIncome = 0
          this.allOutcome = 0
        })
      })
    }.justifyContent(FlexAlign.Start).height('100%').width('100%').margin({ top: 20, bottom: 20 })
  }
}