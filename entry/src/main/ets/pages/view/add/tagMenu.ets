import { bookItem, tagNumMapStr, tagSum } from '../../../utils/dataInterface'

@Component
export struct tagMenu {
  @Consume buttonText: string
  @Consume form: bookItem
  private tagArray: number[] = []

  aboutToAppear(): void {
    for (let i = 0; i < tagSum; i++) {
      this.tagArray.push(i)
    }
  }

  @Builder
  MyMenu() {
    Menu() {
      ForEach(this.tagArray,(tag:number)=>{
        MenuItem({content: `${tagNumMapStr(tag)}`}).onClick(()=>{
          this.form.tag = tag
          this.buttonText = tagNumMapStr(tag)
        })
      })
    }
  }

  build() {
    Button(this.buttonText).bindMenu(this.MyMenu())
  }
}