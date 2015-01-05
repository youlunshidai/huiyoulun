ProductCtrl = require "./../ctrl/productCtrl"

ProductCtrl.productList(null, null, null, "2015-02", null, (err,res) ->
  console.log err,res
)

#ProductCtrl.productDetail("351",(err,res) ->
#  console.log err,res
#)