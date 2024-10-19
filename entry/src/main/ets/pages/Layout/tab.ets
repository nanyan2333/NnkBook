import {bookIndex} from '../view/book/index'
import {settingIndex} from '../view/setting/index'
@Component
export struct TabsPage {

  @State currentIndex: number = 0

  private tabsController: TabsController = new TabsController()

  @Builder TabBuilder(title:string,targetIndex:number,normalImg:Resource,selectedImg:Resource){
    Column(){
      Image(this.currentIndex==targetIndex?selectedImg:normalImg)
        .width(28)
        .height(28)
      Text(title)
        .fontSize(14)
        .margin({top:4})
        .fontColor(this.currentIndex==targetIndex?'#2F88FF':'#999999')
    }
    .backgroundColor("#ffffff")
    .width('100%')
    .height(60)
    .justifyContent(FlexAlign.Center)
    .onClick(()=>{
      this.currentIndex=targetIndex
      this.tabsController.changeIndex(this.currentIndex)
    })
  }

  build() {
    Column() {
      Tabs({barPosition:BarPosition.End,controller:this.tabsController,index:0}){
        TabContent(){
          bookIndex()
        }.tabBar(this.TabBuilder('记账',0,$rawfile('book.svg'),$rawfile('book_select.svg')))
        TabContent(){
          settingIndex()
        }.tabBar(this.TabBuilder('设置',1,$rawfile('setting.svg'),$rawfile('setting_select.svg')))
      }
      .scrollable(false)//去掉左右滑动的效果
      .animationDuration(0)//去掉左右滑动的动画
    }
    .backgroundColor("#eeeeee")
    .width('100%')
    .height('100%')
  }
}
