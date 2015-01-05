class ProductCtrl
  request = require "request"
  config = require "./../config/config.json"

  @productList: (type,page=1,max=10,startDate,order="startDate",fn) ->
    url = "#{config.inf.host}:#{config.inf.port}/product/getlist?#{"type="+type if type?}&page=#{page}&max=#{max}&startDate=#{startDate}&order=#{order}"
    request {url,timeout:3000},(err,response,body) ->
      if err
        fn err
      else
        res = if body? then JSON.parse(body) else {}
        if res.error?
          fn new Error(res.error)
        else
          fn null,res

  @productDetail:(pid,fn) ->
    url = "#{config.inf.host}:#{config.inf.port}/product/getdetail?productId=#{pid}"
    request {url,timeout:3000},(err,response,body) ->
      if err
        fn err
      else
        res = if body? then JSON.parse(body) else {}
        if res.error?
          fn new Error(res.error)
        else
          fn null,res

module.exports = ProductCtrl