
作者：杨光（atany）

博客地址：http://blog.csdn.net/yang8456211

日期：2013.10.16

----------------------------------------------------------------------------------------------
一、文件
根控制器：

YGViewController.h
YGViewController.m
表视图nib：
YGViewController.xib
自定义Cell的nib文件：
CustomCell.xib

-----------------------------------------------------------------------------------------------
二、主要方法：

-(UITableViewCell *)customCellWithOutXib:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath;

不通过xib文件，生成自定义Cell的方法。

-(UITableViewCell *)customCellByXib:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath;

使用xib文件，生成自定义Cell的方法。

《详细解释请参照博客》

声明：如未经作者允许，请勿用于商业用途。违者必究