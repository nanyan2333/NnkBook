import { bookItem, tagNumMapStr } from '../../../utils/dataInterface'

@Component
export struct tagMenu {
  @Consume buttonText:string
  @Consume form: bookItem

  @Builder
  MyMenu() {
    Menu() {
      MenuItem({content: '工资'}).onClick(()=>{
        this.form.tag = 17
        this.buttonText = tagNumMapStr(this.form.tag)
      })
      MenuItem({ content: "医疗" }).onClick(() => {
        this.form.tag = 0
        this.buttonText = tagNumMapStr(this.form.tag)
      })
      MenuItem({ content: "食物" }).onClick(() => {
        this.form.tag = 1
        this.buttonText = "食物"
      })
      MenuItem({ content: "购物" }).onClick(() => {
        this.form.tag = 2
        this.buttonText = "购物"
      })
      MenuItem({ content: "家庭" }).onClick(() => {
        this.form.tag = 3
        this.buttonText = "家庭"
      })
      MenuItem({ content: "水电物业费" }).onClick(() => {
        this.form.tag = 4
        this.buttonText = "水电物业费"
      })
      MenuItem({ content: "交通" }).onClick(() => {
        this.form.tag = 5
        this.buttonText = "交通"
      })
      MenuItem({ content: "教育" }).onClick(() => {
        this.form.tag = 6
        this.buttonText = "教育"
      })
      MenuItem({ content: "娱乐" }).onClick(() => {
        this.form.tag = 7
        this.buttonText = "娱乐"
      })
      MenuItem({ content: "旅行" }).onClick(() => {
        this.form.tag = 8
        this.buttonText = "旅行"
      })
      MenuItem({ content: "保险" }).onClick(() => {
        this.form.tag = 9
        this.buttonText = "保险"
      })
      MenuItem({ content: "储蓄" }).onClick(() => {
        this.form.tag = 10
        this.buttonText = "储蓄"
      })
      MenuItem({ content: "房租" }).onClick(() => {
        this.form.tag = 11
        this.buttonText = "房租"
      })
      MenuItem({ content: "礼物" }).onClick(() => {
        this.form.tag = 12
        this.buttonText = "礼物"
      })
      MenuItem({ content: "订阅服务" }).onClick(() => {
        this.form.tag = 13
        this.buttonText = "订阅服务"
      })
      MenuItem({ content: "税务" }).onClick(() => {
        this.form.tag = 14
        this.buttonText = "税务"
      })
      MenuItem({ content: "捐赠" }).onClick(() => {
        this.form.tag = 15
        this.buttonText = "捐赠"
      })
      MenuItem({ content: "维修保养" }).onClick(() => {
        this.form.tag = 16
        this.buttonText = "维修保养"
      })
      MenuItem({ content: "其他" }).onClick(() => {
        this.form.tag = 18
        this.buttonText = "其他"
      })
    }
  }

  build() {
    Button(this.buttonText).bindMenu(this.MyMenu())
  }
}