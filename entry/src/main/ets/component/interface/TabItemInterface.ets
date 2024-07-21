import set from "./setInterface"


interface barItem {
  title:string,
  //TODO 一个精选barItem中，一个ListItem 两个接口合并，导出barItem
  bar:set[]
}


export default barItem;