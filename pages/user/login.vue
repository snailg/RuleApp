<template>
	<view class="user" :class="AppStyle">
		<view class="header" :style="[{height:CustomBar + 'px'}]">
			<view class="cu-bar bg-white" :style="{'height': CustomBar + 'px','padding-top':StatusBar + 'px'}">
				<view class="action" @tap="back">
					<text class="cuIcon-back"></text>
				</view>
				<view class="content text-bold" :style="[{top:StatusBar + 'px'}]">
					用户登录
				</view>
				<!--  #ifdef H5 || APP-PLUS -->
				<view class="action" @tap="toRegister">
					<text>注册</text>
				</view>
				<!--  #endif -->
			</view>
		</view>
		<view :style="[{padding:NavBar + 'px 10px 0px 10px'}]"></view>
		<view class="user-form">
			<form>
				<view class="cu-form-group">
					<input name="input" placeholder="用户名" v-model="userName"></input>
				</view>
				<view class="cu-form-group">
					<input name="input" placeholder="用户密码" type="password" v-model="password"></input>
				</view>
				<view class="user-btn flex flex-direction">
					<button class="cu-btn bg-blue margin-tb-sm lg" @tap="login">立即登录</button>
					<!-- #ifdef MP -->
					<button class="cu-btn bg-green margin-tb-sm lg" @tap="toRegister">注册新用户</button>
					<!-- #endif -->
					
					
				</view>
			</form>
		</view>
		<!-- #ifdef APP-PLUS -->
		<view class="api-login grid col-3">
			<view class="api-login-box" @tap="toQQlogin">
				<image src="../../static/icon_qq.png"></image>
			</view>
			<view class="api-login-box" @tap="toWexinlogin">
				<image src="../../static/icon_weixin.png"></image>
			</view>
			<view class="api-login-box" @tap="toWeibologin">
				<image src="../../static/icon_weibo.png"></image>
			</view>
		</view>
		<!-- #endif -->
		<!-- #ifdef MP-WEIXIN -->
		<view class="api-login">
			<view class="api-login-box" @tap="toWexinlogin">
				<image src="../../static/icon_weixin.png"></image>
			</view>
		</view>
		<!-- #endif -->
		<!-- #ifdef MP-QQ -->
		<view class="api-login">
			<view class="api-login-box" @tap="toQQlogin">
				<image src="../../static/icon_qq.png"></image>
			</view>
		</view>
		<!-- #endif -->
		<view class="user-foget">
			<text @tap="toFoget">忘记密码？</text>
		</view>
	</view>
</template>

<script>
	import { localStorage } from '../../js_sdk/mp-storage/mp-storage/index.js'
	export default {
		data() {
			return {
				StatusBar: this.StatusBar,
				CustomBar: this.CustomBar,
				NavBar:this.StatusBar +  this.CustomBar,
			AppStyle:this.$store.state.AppStyle,
				userName:"",
				password:"",
				
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
			getCID() {
				var that = this;
				let cid = ''
				// #ifdef APP-PLUS
				let pinf = plus.push.getClientInfo();
				cid = pinf.clientid;
				if(cid){
					that.setClientId(cid);
				}
				// #endif
			},
			setClientId(cid){
				var that = this;
				var token = "";
				if(localStorage.getItem('token')){
					
					token = localStorage.getItem('token');
				}else{
					return false;
				}
				that.$Net.request({
					
					url: that.$API.setClientId(),
					data:{
						"clientId":cid,
						"token":token
					},
					header:{
						'Content-Type':'application/x-www-form-urlencoded'
					},
					method: "get",
					dataType: 'json',
					success: function(res) {
						if(res.data.code==1){
			
							
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
			login() {
				var that = this;
				if (this.password == ""||this.userName == "") {
					uni.showToast({
					    title:"请输入正确的参数",
						icon:'none',
						duration: 1000,
						position:'bottom',
					});
					return false
				}
			
				var data = {
					name: this.userName,
					password: this.password,
				}
				uni.showLoading({
					title: "加载中"
				});
				that.$Net.request({
					
					url: that.$API.userLogin(),
					data:{
						"params":JSON.stringify(that.$API.removeObjectEmptyKey(data)),
					},
					header:{
						'Content-Type':'application/x-www-form-urlencoded'
					},
					method: "post",
					dataType: 'json',
					success: function(res) {
						setTimeout(function () {
							uni.hideLoading();
						}, 1000);
						uni.showToast({
							title: res.data.msg,
							icon: 'none'
						})
						if(res.data.code==1){
							//保存用户信息
							localStorage.setItem('userinfo',JSON.stringify(res.data.data));
							localStorage.setItem('token',res.data.data.token);
							that.getCID();
							var timer = setTimeout(function() {
								uni.switchTab({
									url: '/pages/home/home'
								})
								clearTimeout('timer')
							}, 1000)
						}
					},
					fail: function(res) {
						setTimeout(function () {
							uni.hideLoading();
						}, 1000);
						uni.showToast({
							title: "网络开小差了哦",
							icon: 'none'
						})
						uni.stopPullDownRefresh()
					}
				})
			},
			toRegister(){
				var that = this;
				
				uni.navigateTo({
					url: '/pages/user/register'
				});
			},
			toFoget(){
				var that = this;
				uni.navigateTo({
					url: '/pages/user/foget'
				});
			},
			toQQlogin(){
				//QQ登陆
				//后端直接根据access_token来判断用户的唯一性。
				var that = this;
				uni.login({
					provider: 'qq',
					success: resp => {
						var js_code = resp.code;
						var access_token = "";
						// #ifdef APP-PLUS
						access_token = resp.authResult.access_token;
						// #endif
						uni.getUserInfo({
							provider: 'qq',
							success: function(infoRes) {
								
								var formdata = {
									nickName: infoRes.userInfo.nickname,
									//gender: infoRes.userInfo.gender == '男' ? 1 : 2,
									appLoginType:"qq",
				                    headImgUrl: infoRes.userInfo.figureurl_qq_2,
									// openId: infoRes.userInfo.openId,
									// accessToken: access_token
								};
								// #ifdef APP-PLUS
								formdata.openId=infoRes.userInfo.openId;
								formdata.accessToken=access_token,
								formdata.type = "app";
								// #endif
								// #ifdef MP-QQ
								formdata.type = "applets";
								formdata.js_code = js_code;
								// #endif
								uni.showLoading({
									title: "加载中"
								});
								that.$Net.request({
									
									url: that.$API.userApi(),
									data:{"params":JSON.stringify(that.$API.removeObjectEmptyKey(formdata))},
									header:{
										'Content-Type':'application/x-www-form-urlencoded'
									},
									method: "get",
									dataType: 'json',
									success: function(res) {
										console.log(res)
										setTimeout(function () {
											uni.hideLoading();
										}, 1000);
										uni.showToast({
											title: res.data.msg,
											icon: 'none'
										})
										if(res.data.code==1){
											//保存用户信息
											localStorage.setItem('userinfo',JSON.stringify(res.data.data));
											localStorage.setItem('token',res.data.data.token);
											var timer = setTimeout(function() {
												uni.switchTab({
													url: '/pages/home/home'
												})
												clearTimeout('timer')
											}, 1000)
										}
									},
									fail: function(res) {
										setTimeout(function () {
											uni.hideLoading();
										}, 1000);
										uni.showToast({
											title: "网络开小差了哦",
											icon: 'none'
										})
										uni.stopPullDownRefresh()
									}
								})
								
							}
						});
					},
					fail: err => {
						uni.showToast({
							title: '请求出错啦！',
							icon: 'none',
							duration: 3000
						});
						setTimeout(function () {
							uni.hideLoading();
						}, 1000);
					}
				});
			},
			toWexinlogin(){
				var that = this;
				//微信登陆
				//后端直接根据unionId来判断用户的唯一性。
				
				uni.login({
					provider: 'weixin',
					success: res => {
						
						var js_code = res.code;
						uni.getUserInfo({
							provider: 'weixin',
							success: function(infoRes) {
								
								let formdata = {
									nickName: infoRes.userInfo.nickName,
									//gender: infoRes.userInfo.gender,
									appLoginType:"weixin",
				                    headImgUrl: infoRes.userInfo.avatarUrl,
									// openId: infoRes.userInfo.openId,
									// accessToken: infoRes.userInfo.unionId,
								};
								// #ifdef APP-PLUS
								formdata.openId=infoRes.userInfo.openId;
								formdata.accessToken=infoRes.userInfo.unionId,
								formdata.type = "app";
								formdata.js_code = js_code;
								// #endif
								// #ifdef MP-WEIXIN
								formdata.type = "applets";
								formdata.js_code = js_code;
								// #endif
								uni.showLoading({
									title: "加载中"
								});
								that.$Net.request({
									
									url: that.$API.userApi(),
									data:{"params":JSON.stringify(that.$API.removeObjectEmptyKey(formdata))},
									header:{
										'Content-Type':'application/x-www-form-urlencoded'
									},
									method: "get",
									dataType: 'json',
									success: function(res) {
										setTimeout(function () {
											uni.hideLoading();
										}, 1000);
										uni.showToast({
											title: res.data.msg,
											icon: 'none'
										})
										if(res.data.code==1){
											//保存用户信息
											localStorage.setItem('userinfo',JSON.stringify(res.data.data));
											localStorage.setItem('token',res.data.data.token);
											var timer = setTimeout(function() {
												uni.switchTab({
													url: '/pages/home/home'
												})
												clearTimeout('timer')
											}, 1000)
										}
									},
									fail: function(res) {
										setTimeout(function () {
											uni.hideLoading();
										}, 1000);
										uni.showToast({
											title: "网络开小差了哦",
											icon: 'none'
										})
										uni.stopPullDownRefresh()
									}
								})
								
							}
						});
					},
					fail: err => {
						console.log(err)
						uni.showToast({
							title: '请求出错啦！',
							icon: 'none',
							duration: 3000
						});
						setTimeout(function () {
							uni.hideLoading();
						}, 1000);
					}
				});
			},
			toWeibologin(){
				var that = this;
				//微博登陆
				//后端直接根据access_token来判断用户的唯一性。
				
				uni.login({
					provider: 'sinaweibo',
					success: res => {
						var access_token = '';
						access_token = res.authResult.access_token;
						uni.getUserInfo({
							provider: 'sinaweibo',
							success: function(infoRes) {
								var formdata = {
									nickName: infoRes.userInfo.nickname,
									//gender: infoRes.userInfo.gender == 'm' ? 1 : 2,
									headImgUrl: infoRes.userInfo.avatar_large,
									openId: infoRes.userInfo.id,
									accessToken: access_token,
									appLoginType: 'SINAWEIBO'

								};
								uni.showLoading({
									title: "加载中"
								});
								that.$Net.request({
									
									url: that.$API.userApi(),
									data:{"params":JSON.stringify(that.$API.removeObjectEmptyKey(formdata))},
									header:{
										'Content-Type':'application/x-www-form-urlencoded'
									},
									method: "get",
									dataType: 'json',
									success: function(res) {
										setTimeout(function () {
											uni.hideLoading();
										}, 1000);
										uni.showToast({
											title: res.data.msg,
											icon: 'none'
										})
										if(res.data.code==1){
											//保存用户信息
											localStorage.setItem('userinfo',JSON.stringify(res.data.data));
											localStorage.setItem('token',res.data.data.token);
											var timer = setTimeout(function() {
												uni.switchTab({
													url: '/pages/home/home'
												})
												clearTimeout('timer')
											}, 1000)
										}
									},
									fail: function(res) {
										setTimeout(function () {
											uni.hideLoading();
										}, 1000);
										uni.showToast({
											title: "网络开小差了哦",
											icon: 'none'
										})
										uni.stopPullDownRefresh()
									}
								})
							}
						});
					},
					fail: err => {
						uni.showToast({
							title: '请求出错啦！',
							icon: 'none',
							duration: 3000
						});
						setTimeout(function () {
							uni.hideLoading();
						}, 1000);
					}
				});
			}
			
		}
	}
	
</script>

<style>
</style>
