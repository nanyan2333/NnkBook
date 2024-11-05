export interface bookItem {
  timeMap: string
  type: string
  tag: number
  sum: string
  description: string
}

export const tagSum = 19

export enum TagSelect {
  medical, // 医疗
  food, // 食物
  shopping, // 购物
  home, // 家庭
  utilities, // 公共事业
  transport, // 交通
  education, // 教育
  entertainment, // 娱乐
  travel, // 旅行
  insurance, // 保险
  savings, // 储蓄
  rent, // 房租
  gifts, // 礼物
  subscriptions, // 订阅服务
  taxes, // 税务
  donations, // 捐赠
  maintenance, // 维修保养
  payroll, //工资
  other // 其他
}

export function tagNumMapStr(num: number): string {
  switch (num) {
    case TagSelect.medical:
      return "医疗"
    case TagSelect.food:
      return "食物"
    case TagSelect.shopping:
      return "购物"
    case TagSelect.home:
      return "家庭"
    case TagSelect.utilities:
      return "水电物业费"
    case TagSelect.transport:
      return "交通"
    case TagSelect.education:
      return "教育"
    case TagSelect.entertainment:
      return "娱乐"
    case TagSelect.travel:
      return "旅行"
    case TagSelect.insurance:
      return "保险"
    case TagSelect.savings:
      return "储蓄"
    case TagSelect.rent:
      return "房租"
    case TagSelect.gifts:
      return "礼物"
    case TagSelect.subscriptions:
      return "订阅服务"
    case TagSelect.taxes:
      return "税务"
    case TagSelect.donations:
      return "捐赠"
    case TagSelect.maintenance:
      return "维修保养"
    case TagSelect.payroll:
      return "工资"
    case TagSelect.other:
      return "其他"
    default:
      return '溢出'
  }
}

