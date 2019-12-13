//
//  Enum.h
//  BasicFramework
//
//  Created by u1city on 2019/11/26.
//  Copyright © 2019 u1city. All rights reserved.
//

#ifndef Enum_h
#define Enum_h

typedef NS_ENUM(NSUInteger, PhotographActionSubjectType) {
    PhotographActionSubjectType_PhotographList = 0, // 相册列表
    PhotographActionSubjectType_SelectPhotograph = 1, // 选中相片
    PhotographActionSubjectType_Preview = 2, // 预览按钮
    PhotographActionSubjectType_Edit = 3, // 编辑按钮
    PhotographActionSubjectType_Determine = 4, // 确定按钮
    PhotographActionSubjectType_PhotographEditBack, // 相册编辑返回按钮
};

#endif /* Enum_h */
