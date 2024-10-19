import { createFile, readFile, writeFile,deleteFile } from '../../../utils/file';
import { bookItem } from '../../../utils/dataInterface';
import { JSON } from '@kit.ArkTS';
import { getCurrentDate } from '../../../utils/time'

@Component
export struct bookIndex {
  @State message: bookItem[] = [{
    date: '2024-02-15',
    type: '医疗',
    sum: 73.25,
    description: 'string',
  }, {
    date: '2024-02-15',
    type: '医疗',
    sum: 74.35,
    description: 'string',
  }];
  @State result: string = '';

  build() {
    Column() {
      Button("点击")// 添加按钮的点击事件
        .onClick(() => {
          createFile(getCurrentDate() + '.json').then((res: string) => {
            console.info(res)
          }).catch((rej: string) => {
            console.error(rej)
          })
          writeFile(getCurrentDate() + '.json', this.message).then((res: string) => {
            console.info(res)
          }).catch((rej: string) => {
            console.error(rej)
          })
          readFile(getCurrentDate()+'.json').then((res:bookItem[])=>{
            console.info(res[0].type)
          })
          deleteFile(getCurrentDate()+'.json').then((res:string)=>{
            console.info(res)
          }).catch((rej:string)=>{
            console.error(rej)
          })
        });
    }.padding(40);
  }
}
