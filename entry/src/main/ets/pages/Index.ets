import { TabsPage } from './Layout/tab'


@Entry
@Component
struct Index {
  build() {
    Row() {
      TabsPage()
    }.width('100%').height('100%')
  }
}