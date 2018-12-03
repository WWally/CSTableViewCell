# CSTableViewCell
A high performance drawing of fillets and shadows for the section of the tableview cell

添加TableView代理方法
- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath{

  //给section添加圆角
  [cell addShadowToSectionTableView:tableView atIndexPath:indexPath];
  // 给section加阴影
  [cell addShadowToCellInTableView:tableView atIndexPath:indexPath];

}
