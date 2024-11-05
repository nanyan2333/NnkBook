import { fileIo as fs, ReadOptions } from '@kit.CoreFileKit';
import { common } from '@kit.AbilityKit';
import { buffer } from '@kit.ArkTS';
import { bookItem } from './dataInterface';
import { BusinessError } from '@kit.BasicServicesKit';

// 获取应用文件路径
let context = getContext(this) as common.UIAbilityContext;
let filesDir = context.filesDir;

export function formatFilePath(fileName: string): string {
  return `${filesDir}/${fileName}.json`
}

function delExt(fileName: string): string {
  return fileName.split('.')[0]
}

export function createFile(fileName: string): Promise<string> {
  return new Promise<string>((resolve, reject) => {
    fs.access(formatFilePath(fileName)).then((res: boolean) => {
      if (res) {
        console.info(formatFilePath(fileName) + ':存在文件存在，创建失败')
        reject('文件存在，创建失败')
      } else {
        let file = fs.openSync(formatFilePath(fileName), fs.OpenMode.CREATE)
        fs.closeSync(file.fd)
        console.info(formatFilePath(fileName) + ':创建成功')
        resolve(`${formatFilePath(fileName)}:创建成功`)
      }
    })
  })
}


export function readFile(fileName: string): Promise<bookItem[]> {
  return new Promise<bookItem[]>((resolve, reject) => {
    fs.access(formatFilePath(fileName)).then((res: boolean) => {
      if (res) {
        let file = fs.openSync(formatFilePath(fileName), fs.OpenMode.READ_ONLY)
        let stas = fs.statSync(formatFilePath(fileName))
        let readOptions: ReadOptions = {
          offset: 0,
          length: stas.size
        };
        let readBuffer = new ArrayBuffer(stas.size)
        let readLen = fs.readSync(file.fd, readBuffer, readOptions)
        let buf = buffer.from(readBuffer, 0, readLen)
        fs.closeSync(file.fd)
        if (buf.toString()) {
          console.info(`${formatFilePath(fileName)}内容是：${buf.toString()}`)
          resolve(JSON.parse(buf.toString()) as bookItem[])
        } else {
          console.info(`${formatFilePath(fileName)}内容是：空`)
          resolve([])
        }
      } else {
        createFile(fileName)
        console.info(`${formatFilePath(fileName)}内容是：空,文件不存在`)
        reject([])
      }
    })
  })
}


export function appendFile(fileName: string, obj: bookItem){
  fs.access(formatFilePath(fileName)).then((res) => {
    // console.info("obj is:"+JSON.stringify(obj))
    let arr: bookItem[] = []
    readFile(fileName).then((res) => {
      arr = arr.concat(res)
      // console.info("追加读:"+JSON.stringify(res))
      arr.unshift(obj)
      // console.info("arr is:"+JSON.stringify(arr))
      writeFile(fileName, arr)
    })
  })
}

export function writeFile(fileName: string, message: bookItem[]): Promise<string> {
  return new Promise<string>((resolve, reject) => {
    fs.access(formatFilePath(fileName)).then((res: boolean) => {
      if (res) {
        let file = fs.openSync(formatFilePath(fileName), fs.OpenMode.WRITE_ONLY | fs.OpenMode.TRUNC);
        fs.writeSync(file.fd, JSON.stringify(message));
        console.info('has write:' + JSON.stringify(message))
        fs.closeSync(file.fd)
        resolve('记录成功')
      } else {
        let file = fs.openSync(formatFilePath(fileName), fs.OpenMode.WRITE_ONLY | fs.OpenMode.CREATE);
        fs.writeSync(file.fd, JSON.stringify(message));
        console.info('rej write' + JSON.stringify(message))
        fs.closeSync(file.fd)
        reject('记录成功,新建文件')
      }
    })
  })
}


export function deleteFile(fileName: string): Promise<string> {
  return new Promise<string>((resolve, reject) => {
    fs.access(formatFilePath(fileName)).then((res: boolean) => {
      if (res) {
        fs.unlink(formatFilePath(fileName), (err: BusinessError) => {
          if (err) {
            reject("remove file failed with error message: " + err.message + ", error code: " + err.code)
          } else {
            resolve('删除成功')
          }
        })
      }
    })
  })
}

export function clearMemory(): Promise<string> {
  return new Promise<string>((resolve, reject) => {
    fs.listFile(filesDir).then((res: string[]) => {
      for (let delFileName of res) {
        fs.unlink(filesDir + '/' + delFileName, (err: BusinessError) => {
          if (err) {
            reject('清除内存失败，错误码' + err.code + err.message)
          }
        })
      }
      resolve('清除数据成功')
    })
  })
}