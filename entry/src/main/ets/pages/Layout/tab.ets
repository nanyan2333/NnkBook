import { bookIndex } from '../view/book/index'
import { settingIndex } from '../view/setting/index'
import { addIndex } from '../view/add/index'
import { bookItem } from '../../utils/dataInterface'

import { getNowDate, getLastMonthDates } from '../../utils/time'
import { JSON } from '@kit.ArkTS'
import { readFile } from '../../utils/file'

@Component
export struct TabsPage {
  @State currentIndex: number = 0
  @Provide @Watch('onPushDataChange') todayData: bookItem[] = []
  @Provide allData: bookItem[] = []
  @Provide lastMonth: string[] = getLastMonthDates();
  private tabsController: TabsController = new TabsController()

  onPushDataChange() {
    let last: bookItem = this.todayData[this.todayData.length - 1]
    this.allData.unshift(last)
    // console.info('change on all data:' + JSON.stringify(this.allData))
  }

  aboutToAppear(): void {
    for (let date of this.lastMonth) {
      readFile(date).then((res) => {
        this.allData = [...res, ...this.allData]
      })
    }
    console.info('init'+JSON.stringify(this.allData))
    // console.info('init:' + JSON.stringify(this.allData))
  }

  @Builder
  TabBuilder(title: string, targetIndex: number, normalImg: Resource, selectedImg: Resource) {
    Column() {
      Image(this.currentIndex == targetIndex ? selectedImg : normalImg)
        .width(28)
        .height(28)
      if (this.currentIndex == targetIndex) {
        Text(title)
          .fontSize(14)
          .margin({ top: 4 })
          .fontColor(this.currentIndex == targetIndex ? $r("app.color.Selected_icon") : $r("app.color.icon_color"))
      }
    }
    .backgroundColor($r('sys.color.white'))
    .width('100%')
    .height(60)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex
      this.tabsController.changeIndex(this.currentIndex)
    })
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, controller: this.tabsController, index: 0 }) {
        TabContent() {
          bookIndex()
        }.tabBar(this.TabBuilder('记账', 0, $rawfile('book.svg'), $rawfile('book_select.svg')))

        TabContent() {
          addIndex()
        }.tabBar(this.TabBuilder('新增', 1, $rawfile('add.svg'), $rawfile('add_select.svg')))

        TabContent() {
          settingIndex()
        }.tabBar(this.TabBuilder('设置', 2, $rawfile('setting.svg'), $rawfile('setting_select.svg')))
      }
      .scrollable(false) //去掉左右滑动的效果
      .animationDuration(0) //去掉左右滑动的动画
    }
    .backgroundColor($r("app.color.tabBar"))
    .width('100%')
    .height('100%')
  }
}
