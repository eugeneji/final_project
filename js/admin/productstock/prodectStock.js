

function cateValue(){
   var cate_code = document.getElementById("cate_code");
   var cate_code2 = document.getElementById("cate_code2");
   var cateCode_v = document.getElementById("cateCode_v").value;
   var cateCode2_v= document.getElementById("cateCode2_v").value;
   cate_code.setAttribute('value',cateCode_v);
   cate_code2.setAttribute('value',cateCode2_v);
    show(1)
}
window.onload = function(){
   show(1);
}
function setValue(){
   var cate_code = document.getElementById("cate_code");
   var cate_code2 = document.getElementById("cate_code2");
   var item_name = document.getElementById("item_name");
   
   var cateCode_v = document.getElementById("cateCode_v").value;
   var cateCode2_v= document.getElementById("cateCode2_v").value;
   var itemName_v = document.getElementById("itemName_v").value;
   cate_code.setAttribute('value',cateCode_v);
   cate_code2.setAttribute('value',cateCode2_v);
   item_name.setAttribute('value',itemName_v);
   show(1);
}


function stockManage(idx,price,stock){
   
   var stockForm = document.getElementById("stockControll");
   stockForm.style.display = '';
   var beforeVal = document.getElementById("beforeVal");
   beforeVal.value = stock;
   var itemidx = document.getElementById("idx");
   itemidx.value = idx;
   var itemprice = document.getElementById("price");
   itemprice.value = price;
   
   var allC = document.getElementById("allC");
   allC.style.display = '';

}




function show(cp){
    var data = {};
     data["cate_code"] = document.getElementById("cate_code").value;
     data["cate_code2"] = document.getElementById("cate_code2").value;
     data["item_name"] = document.getElementById("item_name").value;
     data["selectOption"] = document.getElementById("selectOption").value;
     data["cp"] = cp;
   $.ajax({
      url : "selectItemListAdmin.do",
       data:  JSON.stringify(data),
       dataType: "json",
       contentType: 'application/json',
      type:"post",
      success : function(getData){
         selectItemListCallBack(getData);
      }
      
   })
   
}

function selectItemListCallBack(getData){
           var list= getData.list;
   var st = document.getElementById("selectTable");
   var pg = document.getElementById("paging");
   pg.innerHTML = getData.paging;
   st.innerHTML = '';
   var html_txt = '';
   if(list==null||list.length==0){
      html_txt += '<tr>';
        html_txt += '   <td colspan="6">일치하는 정보가 없습니다.</td>';
        html_txt += '</tr>';
      
   }else{
      html_txt += '<tr class="text"><th class="text-center text-nowrap">상품 번호</th><th>상품 이름</th><th>상품 가격</th><th>상품 재고</th><th>등록인</th><th>등록날짜</th><th class="text-center text-nowrap">관리</th></tr>';
         for(var i = 0; i<list.length; i++){
            var tf = list[i].item_tf;
            var selY = tf == 'T'?'selected':'';
            var selN = tf == 'F'?'selected':'';
            var price = list[i].item_price.toLocaleString();
             html_txt += '<tr>';
               html_txt += '   <td class="align-middle" itemIdx="idx'+i+'" name="idx'+i+'">'+list[i].item_idx+'</td>';
               html_txt += '   <td class="reviewText2" id="itemName'+i+'" name="itemName'+i+'">'+list[i].item_name+'</td>';
               html_txt += '   <td id="itemPrice'+i+'" name="itemPrice'+i+'">'+price+'원</td>';
               html_txt += '   <td id="itemStock'+i+'" name="itemStock'+i+'">'+list[i].item_stock+'개</td>';
               html_txt += '   <td id="itemregId'+i+'" name="itemregId'+i+'">'+list[i].item_regid+'</td>';
               html_txt += '   <td id="itemregDate'+i+'" name="itemregDate'+i+'">'+list[i].item_regdate+'</td>';
               html_txt += '   <td id="manageButton"><input type="button" class="btn btn-outline-primary" value="입고" onclick="stockManage('+list[i].item_idx+','+list[i].item_price+','+list[i].item_stock+')"></td>';
               html_txt += '</tr>';
         }
   }
         
         st.innerHTML = html_txt;
      }
   







function afterStock(pl){
   
   va = pl.value;
   va2 = document.getElementById("beforeVal").value;
   price = document.getElementById("price").value;
   va *= 1;
   va2 *= 1;
   if(document.getElementsByName("stock_type")[0].checked){
      document.getElementById("stock").value = va+va2;
   }else{
      document.getElementById("stock").value = -(va-va2);
      document.getElementById("unitcost").value = price;
   }
    
   document.getElementById("stock_unit2").value = va; 
}
function totalCostView(tcv){
   var tcv = tcv.value;
   var unit = document.getElementById("stock_unit2").value;
   tcv *= 1;
   unit *= 1;
   
      document.getElementById("totalCost").value = tcv*unit;   
   
   
}

function closeStockManager(){
   document.getElementById("stock").value = '';
   document.getElementById("totalCost").value = '';   
   document.getElementById("unitcost").value = '';   
   document.getElementById("stock_unit").value = '';
   document.getElementById("stock_unit2").value = '';
   document.getElementById("stock_cause").value = '';
   
   var stockForm = document.getElementById("stockControll");
   stockForm.style.display = 'none';
   var allC = document.getElementById("allC");
   allC.style.display = 'none';
}
function closeMsg(){
   closeStockManager();
   var divNode = document.getElementById("resultDiv");
   divNode.style.display = "none";
   //window.location.reload();
      var allC = document.getElementById("allC");
   allC.style.display = 'none';
   show(1);
}
   function insertStock(){
      
      var n = $("form[name=insertStockForm]").serialize();
      window.alert(n);
      $.ajax({
         url : "updateStock.do",
          data:n,
         type:"post",
         success : function(getData){
            updateStockMsg(getData);
         }
         
      });
      
   }

   function updateStockMsg(getData){
   var divNode = document.getElementById("resultDiv");
   divNode.style.display = "";
 var allC = document.getElementById("allC");
 allC.style.zindex=9;
   var divSpan = document.getElementById("resultSpan");
   divSpan.innerHTML = getData.msg
   }