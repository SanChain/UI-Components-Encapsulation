# UI-Components-ActionSheet
iOS UI组件之封装ActionSheet, 高仿微信的ActionSheet

## 使用方法
1. 把工程里的ActionSheet文件夹直接拖到项目中
2. 
	''[[SCActionSheet shareManager] actionSheetWithTopTitle:@"其它方式登录" bottomTitle:@"验证码登录" topBtnClickBlock:^{
		''NSLog(@"Viewcontroller Click topAction ");
		
	''} bottomBtnClickBlock:^{
		''NSLog(@"Viewcontroller Click bottomAction ");
	''}];
3. 暂提供了三种常用显示方式，后续再优化
