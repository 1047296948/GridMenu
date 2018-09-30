# GridMenu
一个简单的网格菜单实现

用法：

#pragma mark - Create Menu

    FileToolbar* toolbar = [[FileToolbar alloc] initWithFrame:CGRectMake(0, size.height-49, size.width, 49)];
    toolbar.backgroundColor = [UIColor darkGrayColor];
    toolbar.columnCount = 5;
    toolbar.delegate = self;
    [view addSubview:toolbar];
    
    toolbar.items = @[[GridMenuItem itemWithTitle:@"删除" andImage:[[UIImage imageNamed:@"delete"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]],
                      [GridMenuItem itemWithTitle:@"移动" andImage:[[UIImage imageNamed:@"move"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]],
                      [GridMenuItem itemWithTitle:@"复制" andImage:[[UIImage imageNamed:@"copy"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]],
                      [GridMenuItem itemWithTitle:@"属性" andImage:[[UIImage imageNamed:@"info"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]],
                      [GridMenuItem itemWithTitle:@"更多" andImage:[[UIImage imageNamed:@"more"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]]];

#pragma mark - GridMenuDelegate

    - (void)gridMenu:(GridMenu*)gridMenu setupCell:(GridMenuCell*)cell {
        UIColor* color = cell.disable ? [UIColor grayColor] : [UIColor whiteColor];
        cell.imageView.tintColor = color;
        cell.titleLabel.textColor = color;

        cell.imageView.frame = CGRectMake(5, 5, cell.frame.size.width-10, cell.frame.size.height-25);
        cell.titleLabel.frame = CGRectMake(5, cell.frame.size.height-20, cell.frame.size.width-10, 20);
    }
