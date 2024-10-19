import { fileIo as fs, ReadOptions } from '@kit.CoreFileKit';
import { common } from '@kit.AbilityKit';
import { buffer } from '@kit.ArkTS';
import { bookItem } from './dataInterface';
import { BusinessError } from '@kit.BasicServicesKit';

// 获取应用文件路径
let context = getContext(this) as common.UIAbilityContext;
let filesDir = context.filesDir;

export function createFile(fileName: string): Promise<string> {
  return new Promise<string>((resolve, reject) => {
    fs.access(filesDir + fileName).then((res: boolean) => {
      if (res) {
        reject('文件存在，创建失败')
      } else {
        let file = fs.openSync(filesDir + fileName, fs.OpenMode.CREATE)
        fs.closeSync(file.fd)
        resolve(`${fileName}创建成功`)
      }
    })
  })

}

export function readFile(fileName: string): Promise<bookItem[]> {
  return new Promise<bookItem[]>((resolve, reject) => {
    fs.access(filesDir + fileName).then((res: boolean) => {
      if (res) {
        let file = fs.openSync(filesDir + fileName, fs.OpenMode.READ_ONLY)
        let stas = fs.statSync(filesDir + fileName)
        let readOptions: ReadOptions = {
          offset: 0,
          length: stas.size
        };
        let readBuffer = new ArrayBuffer(stas.size)
        let readLen = fs.readSync(file.fd, readBuffer, readOptions)
        let buf = buffer.from(readBuffer, 0, readLen)
        console.info("the content of file: " + buf.toString());
        fs.closeSync(file.fd)
        if (buf.toString()) {
          resolve(JSON.parse(buf.toString()) as bookItem[])
        } else {
          resolve([])
        }
      } else {
        reject([])
      }
    })
  })
}

export function writeFile(fileName: string, message: bookItem[]): Promise<string> {
  return new Promise<string>((resolve, reject) => {
    fs.access(filesDir + fileName).then((res: boolean) => {
      if (res) {
        let file = fs.openSync(filesDir + fileName, fs.OpenMode.WRITE_ONLY | fs.OpenMode.TRUNC);
        // 写入一段内容至文件
        let writeLen = fs.writeSync(file.fd, JSON.stringify(message));
        console.info("The length of str is: " + writeLen);
        fs.closeSync(file.fd)
        resolve('记录成功')
      } else {
        reject('记录失败，文件不存在')
      }
    })
  })
}

export function deleteFile(fileName: string): Promise<string> {
  return new Promise<string>((resolve, reject) => {
    fs.access(filesDir + fileName).then((res: boolean) => {
      if (res) {
        fs.unlink(filesDir + fileName, (err: BusinessError) => {
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