// Index.ets
// 导入页面路由模块

import {TabsPage} from './Layout/tab'



@Entry
@Component
struct Index {
  @State message: string = 'Hello World'


  build() {
    Row(){
      TabsPage()
    }.width('100%').height('100%')
  }
}