<view class="userpost"><view class="header" style="{{'height:'+(CustomBar+'px')+';'}}"><view class="cu-bar bg-white" style="{{'height:'+(CustomBar+'px')+';'+('padding-top:'+(StatusBar+'px')+';')}}"><view data-event-opts="{{[['tap',[['back',['$event']]]]]}}" class="action" bindtap="__e"><text class="cuIcon-back"></text></view><view class="content text-bold" style="{{'top:'+(StatusBar+'px')+';'}}">全站搜索</view><view class="action"></view></view></view><view style="{{'padding:'+(NavBar+'px 10px 0px 10px')+';'}}"></view><view class="all-box"><view class="cu-bar bg-white search"><view class="search-form round"><text class="cuIcon-search"></text><input type="text" placeholder="输入搜索关键字" data-event-opts="{{[['input',[['__set_model',['','searchText','$event',[]]],['searchTag',['$event']]]]]}}" value="{{searchText}}" bindinput="__e"/></view></view><view class="search-type grid col-3"><view data-event-opts="{{[['tap',[['toType',[0]]]]]}}" class="{{['search-type-box',type==0?'active':'']}}" bindtap="__e"><text>文章</text></view><view data-event-opts="{{[['tap',[['toType',[1]]]]]}}" class="{{['search-type-box',type==1?'active':'']}}" bindtap="__e"><text>评论</text></view><view data-event-opts="{{[['tap',[['toType',[2]]]]]}}" class="{{['search-type-box',type==2?'active':'']}}" bindtap="__e"><text>用户</text></view></view><block qq:if="{{type==0}}"><view class="cu-card article no-card"><block qq:for="{{$root.l0}}" qq:for-item="item" qq:for-index="index" qq:key="index"><view data-event-opts="{{[['tap',[['toInfo',['$0'],[[['contentsList','',index]]]]]]]}}" class="cu-card article no-card" bindtap="__e"><view class="cu-item shadow"><block qq:if="{{item.$orig.images.length==0}}"><block><view class="content-author content-header"><image src="{{item.$orig.authorInfo.avatar}}" mode="aspectFill"></image><text class="content-author-name">{{item.$orig.authorInfo.name}}</text><block qq:if="{{item.$orig.category.length>0}}"><text class="article-category">{{item.$orig.category[0].name}}</text></block></view></block></block><view class="title"><view class="text-cut">{{item.m0}}</view></view><view class="content article-content"><block qq:if="{{item.$orig.images.length>0}}"><image src="{{item.$orig.images[0]}}" mode="aspectFill"></image></block><view class="desc"><view class="text-content">{{''+item.m1}}</view><block qq:if="{{item.$orig.images.length>0}}"><view class="content-author"><image src="{{item.$orig.authorInfo.avatar}}" mode="aspectFill"></image><text class="content-author-name">{{item.$orig.authorInfo.name}}</text><block qq:if="{{item.$orig.category.length>0}}"><text class="article-category">{{item.$orig.category[0].name}}</text></block></view></block></view></view><view class="article-content-btn"><view class="cu-tag data-author"><text class="cuIcon-attentionfill"></text>{{item.m2}}</view><view class="cu-tag data-author"><text class="cuIcon-appreciatefill"></text>{{item.$orig.likes}}</view><view class="cu-tag data-author"><text class="cuIcon-messagefill"></text>{{item.$orig.commentsNum}}</view><view class="cu-tag data-time">{{item.m3}}</view></view></view></view></block><block qq:if="{{contentsList.length>0}}"><view data-event-opts="{{[['tap',[['loadMore',['$event']]]]]}}" class="load-more" bindtap="__e"><text>{{moreText}}</text></view></block><block qq:if="{{contentsList.length==0}}"><view class="no-data">暂时没有数据</view></block></view></block><block qq:if="{{type==1}}"><view class="cu-list menu-avatar"><block qq:if="{{commentsList.length==0}}"><view class="no-data">暂时没有评论</view></block><view class="cu-card dynamic no-card" style="margin-top:20rpx;"><block qq:for="{{$root.l1}}" qq:for-item="item" qq:for-index="index" qq:key="index"><block qq:if="{{commentsList.length>0}}"><view class="cu-item"><view class="cu-list menu-avatar comment"><text data-event-opts="{{[['tap',[['ToCopy',['$0'],[[['commentsList','',index,'text']]]]]]]}}" class="copy-comment" bindtap="__e">复制</text><view class="cu-item"><view class="cu-avatar round" style="{{(item.$orig.style)}}"></view><view class="content"><view class="text-grey">{{item.$orig.author}}</view><view class="text-content text-df">{{''+item.$orig.text+''}}</view><view class="bg-grey light padding-sm radius margin-top-sm  text-sm"><view data-event-opts="{{[['tap',[['toInfoComment',['$0','$1'],[[['commentsList','',index,'cid']],[['commentsList','',index,'contenTitle']]]]]]]}}" class="flex" bindtap="__e"><view>{{item.$orig.contenTitle}}</view></view></view><view class="margin-top-sm flex justify-between"><view class="text-gray text-df">{{item.m4}}</view><view><text data-event-opts="{{[['tap',[['commentsAdd',[item.$orig.author+'：'+item.$orig.text,'$0',1],[[['commentsList','',index,'coid']]]]]]]}}" class="cuIcon-messagefill text-gray margin-left-sm" bindtap="__e"></text></view></view></view></view></view></view></block></block></view><block qq:if="{{commentsList.length>0}}"><view data-event-opts="{{[['tap',[['loadMore',['$event']]]]]}}" class="load-more" bindtap="__e"><text>{{moreText}}</text></view></block></view></block><block qq:if="{{type==2}}"><view class="cu-list menu-avatar userList" style="margin-top:4rpx;"><block qq:for="{{userList}}" qq:for-item="item" qq:for-index="index" qq:key="index"><view data-event-opts="{{[['tap',[['toUserContents',['$0'],[[['userList','',index]]]]]]]}}" class="cu-item" bindtap="__e"><view class="cu-avatar round lg" style="{{(item.style)}}"></view><view class="content"><block qq:if="{{item.screenName}}"><view class="text-grey">{{item.screenName+''}}<block qq:if="{{item.groupKey=='contributor'||item.groupKey=='administrator'}}"><text class="cuIcon-lightfill"></text></block></view></block><block qq:else><view class="text-grey">{{item.name+''}}<block qq:if="{{item.groupKey=='contributor'||item.groupKey=='administrator'}}"><text class="cuIcon-lightfill"></text></block></view></block><view class="text-gray text-sm flex"><view class="text-cut">{{''+item.mail+''}}</view></view></view><view class="action"><view class="text-blue text-xs">详情</view></view></view></block><view data-event-opts="{{[['tap',[['loadMore',['$event']]]]]}}" class="load-more" bindtap="__e"><text>{{moreText}}</text></view></view></block></view><block qq:if="{{isLoading==0}}"><view class="loading"><view class="loading-main"><image src="../../static/loading.gif"></image></view></view></block></view>