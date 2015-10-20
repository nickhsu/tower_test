# Tower test

Tower 測試題目

## Design methodology

根據觀察結果，tower目前動態的部分可以分為幾類

* todo（任務）
	* 新增、刪除
	* 指派
	* 修改完成日期
	* 完成任務
	* 評論
* calendar
	* 新增、刪除、修改 
	* 評論
* document
	* 新增、刪除、修改
	* 評論
* project
	* 新增、刪除

以上所有的操作都會產生相對應的event，未來還有可能會新增其他事件型態，所以要保證event有一定的擴充性，rails有兩種方式可以實現

* STI(Single-table inheritance)
* ActiveRecord::Store

由於以上所有的操作所產生的資料交集並不大，所以使用STI會產生大量的表以及空欄位。二來event的呈現是使用瀑布流的方式，並沒有做複雜的query，所以我選擇使用ActiveRecord::Store。目前ActiveRecord::Store的缺點是將資料存為json型態後，無法使用SQL查詢資料，不過這個問題在 postgresql, mysql 5.7+ 以上版本的數據庫都提供 json type query，所以問題不大。