# flutter_demo

HyperPay Flutter Demo

version 1.00

## contents :

- Mobile SDK Ready UI Demo : https://hyperpay.docs.oppwa.com/tutorials/mobile-sdk/prebuilt-ui

- Mobile SDK Custom UI Demo : https://hyperpay.docs.oppwa.com/tutorials/mobile-sdk/custom-ui/integration


- Ready UI :

1- Follow the first Integration : 
https://hyperpay.docs.oppwa.com/tutorials/mobile-sdk/first-integration

2- change the ShopperResultURL to your bundle ID (IOS) , Package Name (Android)
   
   - Android : - Android Manifest <data android:scheme="com.mosab.demohyperpayapp" /> 

  				replace 'com.mosab.demohyperpayapp' with your Package Name.

  			   - MainActivity :

  			    replace 'com.mosab.demohyperpayapp://result' with 'Package_name://result'

  			    replace 'com.mosab.demohyperpayapp' with your package name in 'onNewIntent() function'


  	- IOS : - AppDelegate :

  			  replace 'com.mosab.demohyperpayapp://result' with 'Bundle_ID://result'

  			-  In Xcode, click on your project in the Project Navigator and navigate to App Target > Info > URL Types.
			-  Click [+] to add a new URL type
			-  Under URL Schemes, enter your app switch return URL scheme. This scheme must start with your app's Bundle ID.
			-  add URLs to a whitelist in your app's Info.plist:
				<key>LSApplicationQueriesSchemes</key>
				<array>
    			<string>com.companyname.appname.payments</string>
				</array>


Reference : https://hyperpay.docs.oppwa.com/tutorials/mobile-sdk/prebuilt-ui/asynchronous-payments


3- APPLEPAY :

just change the merchant id in the AppeDelegate.swift.

Reference : https://hyperpay.docs.oppwa.com/tutorials/mobile-sdk/apple-pay

