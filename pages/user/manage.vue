<template>
	<view class="user" :class="AppStyle">
		<view class="header" :style="[{height:CustomBar + 'px'}]">
			<view class="cu-bar bg-white" :style="{'height': CustomBar + 'px','padding-top':StatusBar + 'px'}">
				<view class="action" @tap="back">
					<text class="cuIcon-back"></text>
				</view>
				<view class="content text-bold" :style="[{top:StatusBar + 'px'}]">
					管理员中心
				</view>
				<view class="action">
				</view>
			</view>
		</view>
		<view :style="[{padding:NavBar + 'px 10px 0px 10px'}]"></view>
		<view class="data-box manage-data" >
			<view class="user-data grid col-4">
				<view class="user-data-box">
					<view class="user-data-value">{{allContents}}</view>
					<view class="user-data-title">全站文章</view>
				</view>
				<view class="user-data-box">
					<view class="user-data-value">{{allComments}}</view>
					<view class="user-data-title">全站评论</view>
				</view>
				<view class="user-data-box">
					<view class="user-data-value">{{allShop}}</view>
					<view class="user-data-title">全站商品</view>
				</view>
				<view class="user-data-box">
					<view class="user-data-value">{{allUsers}}</view>
					<view class="user-data-title">用户注册</view>
				</view>
			</view>
		</view>
		<view class="data-box">
			<view class="cu-bar bg-white">
				<view class="action data-box-title">
					<text class="cuIcon-titles text-rule"></text>用户模块
				</view>
				<view class="action more">
					
				</view>
			</view>
			<view class="index-sort grid col-4">
				<view class="index-sort-box">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/users')">
							<view class="index-sort-i" style="background-color: #fa5c00;">
								<text class="cuIcon-friend"></text>
							</view>
							<view class="index-sort-text">
								用户管理
							</view>
						</view>
					</waves>
				</view>
				<view class="index-sort-box" v-if="group=='administrator'">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/senduser')">
							<view class="index-sort-i" style="background-color: #2889a6;">
								<text class="cuIcon-light"></text>
							</view>
							<view class="index-sort-text">
								发送消息
							</view>
						</view>
					</waves>
				</view>
				<view class="index-sort-box" v-if="group=='administrator'">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/invitation')">
							<view class="index-sort-i" style="background-color: #0bb335;">
								<text class="cuIcon-friendadd"></text>
							</view>
							<view class="index-sort-text">
								邀请码管理
							</view>
						</view>
					</waves>
				</view>
				<view class="index-sort-box" v-if="group=='administrator'">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/clean')">
							<view class="index-sort-i">
								<text class="cuIcon-file"></text>
							</view>
							<view class="index-sort-text">
								常规数据清理
							</view>
						</view>
					</waves>
				</view>
				<view class="index-sort-box" v-if="group=='administrator'">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/userClean')">
							<view class="index-sort-i">
								<text class="cuIcon-file"></text>
							</view>
							<view class="index-sort-text">
								用户数据清理
							</view>
						</view>
					</waves>
				</view>
				<view class="index-sort-box">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/banuser')">
							<view class="index-sort-i" style="background-color: #333333;">
								<text class="cuIcon-warnfill"></text>
							</view>
							<view class="index-sort-text">
								封禁用户
							</view>
						</view>
					</waves>
				</view>
				<view class="index-sort-box">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/endException')">
							<view class="index-sort-i" style="background-color: #ea4eea;">
								<text class="cuIcon-paintfill"></text>
							</view>
							<view class="index-sort-text">
								解除异常
							</view>
						</view>
					</waves>
				</view>
			</view>
		</view>
		<view class="data-box">
			<view class="cu-bar bg-white">
				<view class="action data-box-title">
					<text class="cuIcon-titles text-rule"></text>内容模块
				</view>
				<view class="action more">
					
				</view>
			</view>
			<view class="index-sort grid col-4">
				<view class="index-sort-box">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/contents')">
							<view class="index-sort-i" style="background-color: #009595;">
								<text class="cuIcon-text"></text>
							</view>
							<view class="index-sort-text">
								内容管理
							</view>
						</view>
					</waves>
				</view>
				<view class="index-sort-box">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/comments')">
							<view class="index-sort-i">
								<text class="cuIcon-favorfill"></text>
							</view>
							<view class="index-sort-text">
								评论管理
							</view>
						</view>
					</waves>
				</view>
				<view class="index-sort-box">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/shop')">
							<view class="index-sort-i">
								<text class="cuIcon-shop"></text>
							</view>
							<view class="index-sort-text">
								商品管理
							</view>
						</view>
					</waves>
				</view>				
				<view class="index-sort-box" v-if="group=='administrator'">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/ads')">
							<view class="index-sort-i" style="background-color: #7a4ada;">
								<text class="cuIcon-read"></text>
							</view>
							<view class="index-sort-text">
								广告管理
							</view>
						</view>
					</waves>
				</view>
				<view class="index-sort-box" v-if="group=='administrator'">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/chat')">
							<view class="index-sort-i" style="background-color: #e70073;">
								<text class="cuIcon-weixin"></text>
							</view>
							<view class="index-sort-text">
								聊天室管理
							</view>
						</view>
					</waves>
				</view>
				<view class="index-sort-box">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/space')">
							<view class="index-sort-i" style="background-color: #eb4d18;">
								<text class="cuIcon-new"></text>
							</view>
							<view class="index-sort-text">
								动态管理
							</view>
						</view>
					</waves>
				</view>
				
			</view>
		</view>
		<view class="data-box" v-if="group=='administrator'">
			<view class="cu-bar bg-white">
				<view class="action data-box-title">
					<text class="cuIcon-titles text-rule"></text>财务模块
				</view>
				<view class="action more">
					
				</view>
			</view>
			<view class="index-sort grid col-4">
				<view class="index-sort-box" v-if="group=='administrator'">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/finance')">
							<view class="index-sort-i" style="background-color: #e72323;">
								<text class="cuIcon-vipcard"></text>
							</view>
							<view class="index-sort-text">
								财务中心
							</view>
						</view>
					</waves>
				</view>
				<view class="index-sort-box" v-if="group=='administrator'">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/recharge')">
							<view class="index-sort-i" style="background-color: #1747e6;">
								<text class="cuIcon-pay"></text>
							</view>
							<view class="index-sort-text">
								快捷充扣
							</view>
						</view>
					</waves>
				</view>
				<view class="index-sort-box" v-if="group=='administrator'">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/withdraw')">
							<view class="index-sort-i" style="background-color: #f1a100;">
								<text class="cuIcon-vipcard"></text>
							</view>
							<view class="index-sort-text">
								提现审核
							</view>
						</view>
					</waves>
				</view>
				<view class="index-sort-box" v-if="group=='administrator'">
					<waves itemClass="butclass">
						<view class="index-sort-main" @tap="toLink('/pages/manage/tokenpay')">
							<view class="index-sort-i">
								<text class="cuIcon-ticket"></text>
							</view>
							<view class="index-sort-text">
								卡密管理
							</view>
						</view>
					</waves>
				</view>
			</view>
		</view>
		<block v-if="group=='administrator'">
			<view class="data-box">
				<view class="ruleApi-Info grid col-2" v-if="ruleApiInfo">
					<view class="ruleApi-Info-box">
						<view class="ruleApi-title">客户端最新版本</view>
						<view class="ruleApi-name">RuleApp</view>
						<view class="ruleApi-version text-gray">{{ruleApiInfo.ruleappVersion}}</view>
						<text class="cu-btn bg-blue" @tap="toUrl(ruleApiInfo.ruleappDt)">获取</text>
					</view>
					<view class="ruleApi-Info-box">
						<view class="ruleApi-title">服务端最新版本</view>
						<view class="ruleApi-name">RuleApi</view>
						<view class="ruleApi-version text-gray">{{ruleApiInfo.ruleapiVersion}}</view>
						<text class="cu-btn bg-blue" @tap="toUrl(ruleApiInfo.ruleapiDt)">获取</text>
					</view>
				</view>
			</view>
			<view class="data-box">
				<view class="cu-list menu">
					<view class="cu-item" @tap="toReward">
						<view class="content">
							<text class="cuIcon-presentfill text-red"></text>
							<text>打赏开发者</text>
						</view>
					</view>
				</view>
			</view>
			<view class="data-box">
				<view class="cu-list menu">
					<view class="cu-item" @tap="toWord">
						<view class="content">
							<text class="cuIcon-hotfill text-blue"></text>
							<text>RuleAPP教程文档</text>
						</view>
					</view>
				</view>
			</view>
		</block>
	</view>
</template>

<script>
	import waves from '@/components/xxley-waves/waves.vue';
	import { localStorage } from '../../js_sdk/mp-storage/mp-storage/index.js'
	export default {
		data() {
			return {
				StatusBar: this.StatusBar,
				CustomBar: this.CustomBar,
				NavBar:this.StatusBar +  this.CustomBar,
			AppStyle:this.$store.state.AppStyle,
				
				
				userInfo:null,
				token:"",
				allComments:"",
				allUsers:"",
				allShop:"",
				allContents:"",
				
				ruleApiInfo:null,
				
				group:"",
				
			}
		},
		onPullDownRefresh(){
			var that = this;
			
		},
		onShow(){
			var that = this;
			// #ifdef APP-PLUS
			
			plus.navigator.setStatusBarStyle("dark")
			
			// #endif
			if(localStorage.getItem('userinfo')){
				
				that.userInfo = JSON.parse(localStorage.getItem('userinfo'));
				that.userInfo.style = "background-image:url("+that.userInfo.avatar+");";
				that.group = that.userInfo.group;
			}
			if(localStorage.getItem('token')){
				
				that.token = localStorage.getItem('token');
				that.allData();
			}
			
			that.getInfo();
		},
		onLoad() {
			var that = this;
			// #ifdef APP-PLUS || MP
			that.NavBar = this.CustomBar;
			// #endif
		},
		methods: {
			back(){
				uni.navigateBack({
					delta: 1
				});
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
			},
			allData() {
				var that = this;
				that.$Net.request({
					
					url: that.$API.allData(),
					data:{
						"token":that.token
					},
					header:{
						'Content-Type':'application/x-www-form-urlencoded'
					},
					method: "get",
					dataType: 'json',
					success: function(res) {
						if(res.data.code==1){
							that.allComments = res.data.data.allComments;
							that.allUsers = res.data.data.allUsers;
							that.allShop = res.data.data.allShop;
							that.allContents = res.data.data.allContents;
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
			getInfo() {
				var that = this;
				that.$Net.request({
					
					url: "https://www.ruletree.club/ruleApiInfo.php",
					header:{
						'Content-Type':'application/x-www-form-urlencoded'
					},
					method: "get",
					dataType: 'json',
					success: function(res) {
						if(res.data.ruleappVersion){
							that.ruleApiInfo = res.data;
						}
						
					},
					fail: function(res) {
						// uni.showToast({
						// 	title: "网络开小差了哦",
						// 	icon: 'none'
						// })
					}
				})
			},
			toUrl(url){
				// #ifdef APP-PLUS
				plus.runtime.openURL(url) 
				// #endif
				// #ifdef H5
				window.open(url)
				// #endif
			},
			toReward(){
				var url = "https://www.ruletree.club/sponsor.html";
				// #ifdef APP-PLUS
				plus.runtime.openURL(url) 
				// #endif
				// #ifdef H5
				window.open(url)
				// #endif
			},
			toWord(){
				var url = "https://www.ruletree.club/tag/RuleApp/";
				// #ifdef APP-PLUS
				plus.runtime.openURL(url) 
				// #endif
				// #ifdef H5
				window.open(url)
				// #endif
			}
		},
		components: {
			waves
		}
	}
</script>

<style>
</style>
