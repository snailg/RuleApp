<template>
	<view :class="AppStyle">
		<view class="header" :style="[{height:CustomBar + 'px'}]">
			<view class="cu-bar bg-white" :style="{'height': CustomBar + 'px','padding-top':StatusBar + 'px'}">
				<view class="action" @tap="toSearch">
					<text class="cuIcon-search"></text>
				</view>
				<view class="content text-bold" :style="[{top:StatusBar + 'px'}]">
					发现
				</view>
				<!--  #ifdef H5 || APP-PLUS -->
				<view class="action header-btn">
					
					<text class="cuIcon-notice" @tap="toLink('/pages/user/inbox')">
						<text class="noticeSum bg-red" v-if="noticeSum>0">{{noticeSum}}</text>
					</text>
				</view>
				<!--  #endif -->
			</view>
		</view>
		<view :style="[{padding:NavBar + 'px 10px 0px 10px'}]"></view>
		
		<view class="data-box">
			<view class="cu-bar bg-white">
				<view class="action data-box-title">
					<text class="cuIcon-titles text-rule"></text> 排行榜
				</view>
				<view class="action more" @tap='toTopContents("排行榜","commentsNum")'>
					<text>更多热门</text><text class="cuIcon-right"></text>
				</view>
				
			</view>
			<view class="top">
				<view class="top-box"  v-for="(item,index) in topList" :key="index" @tap="toInfo(item)">
					<text>{{index+1}}</text>{{item.title}}
				</view>
			</view>
		</view>
		<view class="data-box">
			<view class="cu-bar bg-white">
				<view class="action data-box-title">
					<text class="cuIcon-titles text-rule"></text> 工具库
				</view>
				<view class="action more">
					
				</view>
			</view>
			<view class="index-sort grid col-4 tool-sort">
				<view class="index-sort-box">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="goPage('/pages/contents/imagetoday')">
							<view class="index-sort-i" style="background-color: #039a54;">
								<text class="cuIcon-picfill"></text>
							</view>
							<view class="index-sort-text">
								图库
							</view>
						</view>
					</waves>
				</view>
				
				<!--  #ifdef H5 || APP-PLUS -->
				<view class="index-sort-box">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="goPage('/pages/ads/home')">
							<view class="index-sort-i" style="background-color: #7f165e;">
								<text class="cuIcon-read"></text>
							</view>
							<view class="index-sort-text">
								广告位
							</view>
						</view>
					</waves>
				</view>
				<!--  #endif -->
				<view class="index-sort-box">
					<waves itemClass="butclass">
						<view class="index-sort-main"  @tap="goPage('/pages/contents/shop')">
							<view class="index-sort-i" style="background-color: #ff3333;">
								<text class="cuIcon-taoxiaopu"></text>
							</view>
							<view class="index-sort-text">
								积分商城
							</view>
						</view>
					</waves>
				</view>
				<!--  #ifdef MP -->
				<view class="index-sort-box">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="goPage('/pages/contents/randlist')">
							<view class="index-sort-i">
								<text class="cuIcon-refresh"></text>
							</view>
							<view class="index-sort-text">
								随机阅读
							</view>
						</view>
					</waves>
				</view>
				<!--  #endif -->
				<view class="index-sort-box">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="goPage('/pages/home/tool')">
							<view class="index-sort-i" style="background-color: #7d7c7c;">
								<text class="cuIcon-similar"></text>
							</view>
							<view class="index-sort-text">
								更多
							</view>
						</view>
					</waves>
				</view>
			</view>
		</view>
		<view class="data-box">
			<view class="cu-bar bg-white">
				<view class="action data-box-title">
					<text class="cuIcon-titles text-rule"></text> 推荐文章
				</view>
				<view class="action more" @tap="toRecommend">
					<text>阅读更多</text><text class="cuIcon-right"></text>
				</view>
			</view>
			<view class="cu-card article no-card">
				
				<view class="cu-item shadow"  v-for="(item,index) in recommendList" :key="index" @tap="toInfo(item)">
					<view class="content">
						<image v-if="item.images.length>0" :src="item.images[0]"
						 mode="aspectFill"></image>
						<view class="desc">
							<view class="text-content">{{replaceSpecialChar(item.title)}}</view>
							<view class="text-i">
								<view class="cu-tag bg-blue light sm round" v-if="item.category.length>0">{{item.category[0].name}}</view>
								<view class="cu-tag data-time">{{formatDate(item.created)}}</view>
							</view>
						</view>
					</view>
				</view>
			</view>
		</view>
		
		<view class="data-box" style="display: none;">
			<view class="cu-bar bg-white">
				<view class="action data-box-title">
					<text class="cuIcon-titles text-rule"></text> 内容分类
				</view>
				<view class="action more" @tap="toAllcategory">
					<text>全部分类</text><text class="cuIcon-right"></text>
				</view>
			</view>
			<view class="category grid col-3">
				<view class="category-box"  v-for="(item,index) in metaList" v-if="item.parent==0" @tap="toCategoryContents(item.name,item.mid)" :key="index">
					<view class="category-main">
						{{item.name}}
					</view>
				</view>
			</view>
		</view>
		<view class="data-box">
			<view class="cu-bar bg-white">
				<view class="action data-box-title">
					<text class="cuIcon-titles text-rule"></text> 标签云
				</view>
				<view class="action more" @tap="toAlltag">
					<text>更多标签</text><text class="cuIcon-right"></text>
				</view>
			</view>
			<view class="tags">
				
				<text class="tags-box" v-for="(item,index) in tagList" @tap='toCategoryContents("#"+item.name+"#",item.mid)'>
					{{item.name}}
				</text>
				
			</view>
		</view>
		<view class="ads-banner" v-if="bannerAdsInfo!=null">
			<image :src="bannerAdsInfo.img" mode="widthFix" @tap="goAds(bannerAdsInfo)"></image>
		</view>
		<!--加载遮罩-->
		<view class="loading" v-if="isLoading==0">
			<view class="loading-main">
				<image src="../../static/loading.gif"></image>
			</view>
		</view>
		<!--加载遮罩结束-->
		<view class="full-noLogin" v-if="noLogin">
			<view class="full-noLogin-main">
				<view class="full-noLogin-text">
					您需要登录后才可以查看内容哦！
				</view>
				<view class="full-noLogin-btn">
					<view class="cu-btn bg-blue" @tap="goLogin()">
						立即登录
					</view>
				</view>
			</view>
		</view>
		<!--登录遮罩结束-->
		<!--  #ifdef APP-PLUS -->
		<view style="height: 100upx;"></view>
		<Tabbar :current="1"></Tabbar>
		<!--  #endif -->
	</view>
</template>

<script>
	import waves from '@/components/xxley-waves/waves.vue';
	// #ifdef APP-PLUS
	import Tabbar from '@/pages/components/tabBar.vue'
	// #endif
	import { localStorage } from '../../js_sdk/mp-storage/mp-storage/index.js'
	export default {
		data() {
			return {
				StatusBar: this.StatusBar,
				CustomBar: this.CustomBar,
				NavBar:this.StatusBar +  this.CustomBar,
				AppStyle:this.$store.state.AppStyle,
				
				topList:[],
				metaList:[],
				tagList:[],
				recommendList:[],
				isLoading:0,
				
				ads:"",
				bannerAds:[],
				bannerAdsInfo:null,
				
				noticeSum:0,
				token:"",
				noLogin:false
			}
		},
		onPullDownRefresh(){
			var that = this;
			that.loading();
			var timer = setTimeout(function() {
				uni.stopPullDownRefresh();
			}, 1000)
		},
		onShow(){
			var that = this;
			that.getAdsCache();
			// #ifdef APP-PLUS
			uni.hideTabBar({
				animation: false
			})
			that.getAds();
			
			plus.navigator.setStatusBarStyle("dark")
			// #endif
			that.allCache();
			if(localStorage.getItem('token')){
				
				that.token = localStorage.getItem('token');
			}
			that.unreadNum();
			that.getRecommend();
		},
		onLoad() {
			var that = this;
			// #ifdef APP-PLUS || MP
			that.NavBar = this.CustomBar;
			// #endif
			that.loading();
		},
		methods:{
			getAdsCache(){
				var that = this;
				if(localStorage.getItem('bannerAds')){
					that.bannerAds = JSON.parse(localStorage.getItem('bannerAds'));
					
					var num = that.bannerAds.length;
					if(num>0){
						var rand = Math.floor(Math.random()*num);
						that.bannerAdsInfo = that.bannerAds[rand];
					}
				}
			},
			loading(){
				var that = this;
				that.getRecommend();
				that.getTopList();
				that.getMetaList();
				that.getTagList();
			},
			replaceSpecialChar(text) {
			  text = text.replace(/&quot;/g, '"');
			  text = text.replace(/&amp;/g, '&');
			  text = text.replace(/&lt;/g, '<');
			  text = text.replace(/&gt;/g, '>');
			  text = text.replace(/&nbsp;/g, ' ');
			  return text;
			},
			formatDate(datetime) {
				var datetime = new Date(parseInt(datetime * 1000));
				var year = datetime.getFullYear(),
					month = ("0" + (datetime.getMonth() + 1)).slice(-2),
					date = ("0" + datetime.getDate()).slice(-2),
					hour = ("0" + datetime.getHours()).slice(-2),
					minute = ("0" + datetime.getMinutes()).slice(-2);
				var result = year + "-" + month + "-" + date + " " + hour + ":" + minute;
				return result;
			},
			allCache(){
				var that = this;
				if(localStorage.getItem('topList')){
					that.topList = JSON.parse(localStorage.getItem('topList'));
					var timer = setTimeout(function() {
						that.isLoading=1;
						clearTimeout('timer')
					}, 300)
				}
				if(localStorage.getItem('recommendList')){
					that.recommendList = JSON.parse(localStorage.getItem('recommendList'));
				}
				if(localStorage.getItem('find_metaList')){
					that.metaList = JSON.parse(localStorage.getItem('find_metaList'));
				}
				if(localStorage.getItem('find_tagList')){
					that.tagList = JSON.parse(localStorage.getItem('find_tagList'));
				}
			},
			getAds(){
				var that = this;
				
				that.$Net.request({
					url: that.$API.GetAds(),
					header:{
						'Content-Type':'application/x-www-form-urlencoded'
					},
					method: "post",
					dataType: 'json',
					success: function(res) {
						if(res.data.isAds==1){
							that.ads= res.data.ad1.split("|");
						}
						
					},
					fail: function(res) {
						
					}
				})
			},
			goLogin(){
				var that = this;
				uni.navigateTo({
				    url: '/pages/user/login'
				});
			},
			getRecommend(){
				var that = this;
				var data = {
					"type":"post",
					"isrecommend":1
				}
				var token = "";
				if(localStorage.getItem('userinfo')){
					var userInfo = JSON.parse(localStorage.getItem('userinfo'));
					token=userInfo.token;
				}
				that.$Net.request({
					url: that.$API.getContentsList(),
					data:{
						"searchParams":JSON.stringify(that.$API.removeObjectEmptyKey(data)),
						"limit":5,
						"page":1,
						"order":"modified",
						"token":token
					},
					header:{
						'Content-Type':'application/x-www-form-urlencoded'
					},
					method: "post",
					dataType: 'json',
					success: function(res) {
						
						if(res.data.code==1){
							that.noLogin = false;
							var list = res.data.data;
							if(list.length>0){
							
								that.recommendList = list;
								
							}else{
								that.recommendList = [];
							}
							localStorage.setItem('recommendList',JSON.stringify(that.recommendList));
						}else{
							if(res.data.msg=="用户未登录或Token验证失败"){
								that.noLogin = true;
							}
						}
					},
					fail: function(res) {
						
					}
				})
			},
			getTopList(){
				var that = this;
				var info = {
					"type":"post"
				}
				var token = "";
				if(localStorage.getItem('userinfo')){
					var userInfo = JSON.parse(localStorage.getItem('userinfo'));
					token=userInfo.token;
				}
				that.$Net.request({
					url: that.$API.getContentsList(),
					data:{
						"searchParams":JSON.stringify(that.$API.removeObjectEmptyKey(info)),
						"limit":5,
						"page":1,
						"order":"commentsNum",
						"token":token
					},
					header:{
						'Content-Type':'application/x-www-form-urlencoded'
					},
					method: "post",
					dataType: 'json',
					success: function(res) {
						if(res.data.code==1){
							var list = res.data.data;
							if(list.length>0){
							
								that.topList = list;
								localStorage.setItem('topList',JSON.stringify(list));
							}
						}
						var timer = setTimeout(function() {
							that.isLoading=1;
							clearTimeout('timer')
						}, 300)
					},
					fail: function(res) {
						uni.showToast({
							title: "网络开小差了哦",
							icon: 'none'
						})
						var timer = setTimeout(function() {
							that.isLoading=1;
							clearTimeout('timer')
						}, 300)
					}
				})
			},
			getMetaList(){
				var that = this;
				var data = {
					"type":"category",
					"parent":0
				}
				that.$Net.request({
					url: that.$API.getMetasList(),
					data:{
						"searchParams":JSON.stringify(that.$API.removeObjectEmptyKey(data)),
						"limit":15,
						"page":1,
						"order":"order"
					},
					header:{
						'Content-Type':'application/x-www-form-urlencoded'
					},
					method: "post",
					dataType: 'json',
					success: function(res) {
						if(res.data.code==1){
							var list = res.data.data;
							if(list.length>0){
							
								that.metaList = list;
								localStorage.setItem('find_metaList',JSON.stringify(that.metaList));
							}
						}
					},
					fail: function(res) {
					}
				})
			},
			goAds(data){
				var that = this;
				var url = data.url;
				var type = data.urltype;
				// #ifdef APP-PLUS
				if(type==1){
					plus.runtime.openURL(url);
				}
				if(type==0){
					plus.runtime.openWeb(url);
				}
				// #endif
				// #ifdef H5
				window.open(url)
				// #endif
			},
			getTagList(){
				var that = this;
				var data = {
					"type":"tag"
				}
				that.$Net.request({
					url: that.$API.getMetasList(),
					data:{
						"searchParams":JSON.stringify(that.$API.removeObjectEmptyKey(data)),
						"limit":20,
						"page":1,
						"order":"count"
					},
					header:{
						'Content-Type':'application/x-www-form-urlencoded'
					},
					method: "post",
					dataType: 'json',
					success: function(res) {
						if(res.data.code==1){
							var list = res.data.data;
							if(list.length>0){


								that.tagList = list;
								
								localStorage.setItem('find_tagList',JSON.stringify(that.tagList));
							}
						}
					},
					fail: function(res) {
					}
				})
			},
			toSearch(){
				var that = this;
				if(that.noLogin){
					uni.navigateTo({
					    url: '/pages/user/login'
					});
					return false;
				}
				uni.navigateTo({
				    url: '/pages/contents/search'
				});
			},
			toCategoryContents(title,id){
				var that = this;
				var type="meta";
				uni.navigateTo({
				    url: '/pages/contents/contentlist?title='+title+"&type="+type+"&id="+id
				});
			},
			toTopContents(title,id){
				var that = this;
				var type="meta";
				uni.navigateTo({
				    url: '/pages/contents/contentlist?title='+title+"&type=top&id="+id
				});
			},
			toInfo(data){
				var that = this;
				
				uni.navigateTo({
				    url: '/pages/contents/info?cid='+data.cid+"&title="+data.title
				});
			},
			toAlltag(){
				var that = this;
				
				uni.navigateTo({
				    url: '/pages/contents/alltag'
				});
			},
			toAllcategory(){
				var that = this;
				uni.navigateTo({
				    url: '/pages/contents/allcategory'
				});
			},
			goPage(url){
				var that = this;
				
				uni.navigateTo({
				    url: url
				});
			},
			toRecommend(){
				var that = this;
				
				uni.navigateTo({
				    url: '/pages/contents/recommend'
				});
			},
			toGroup(){
				var url = that.$API.GetGroupUrl();
				// #ifdef APP-PLUS
				plus.runtime.openURL(url) 
				// #endif
				// #ifdef H5
				window.open(url)
				// #endif
			},
			toAds(url){
				// #ifdef APP-PLUS
				plus.runtime.openURL(url) 
				// #endif
				// #ifdef H5
				window.open(url)
				// #endif
			},
			unreadNum() {
				var that = this;
				that.$Net.request({
					
					url: that.$API.unreadNum(),
					data:{
						"token":that.token
					},
					header:{
						'Content-Type':'application/x-www-form-urlencoded'
					},
					method: "post",
					dataType: 'json',
					success: function(res) {
						if(res.data.code==1){
							that.noticeSum = res.data.data;
						}
					},
					fail: function(res) {
						uni.showToast({
							title: "网络开小差了哦",
							icon: 'none'
						})
					}
				})
			},
			toLink(text){
				var that = this;
				
				if(!localStorage.getItem('token')||localStorage.getItem('token')==""){
					uni.showToast({
						title: "请先登录哦",
						icon: 'none'
					})
					return false;
				}
				uni.navigateTo({
					url: text
				});
			}
		},
		// #ifdef APP-PLUS
		components: {
			waves,
			Tabbar
		},
		// #endif
		
		// #ifdef H5 || MP
		components: {
			waves
		},
		// #endif
	}
</script>

<style>
</style>