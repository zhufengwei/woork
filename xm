<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>轻奢自助点餐系统</title>
<style>
  *{
    box-sizing:border-box;
    margin:0;
    padding:0;
    font-family:-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
  }
  body{
    background:#F7F8FA;
    color:#222;
    max-width:480px;
    margin:0 auto;
    padding-bottom:80px;
  }

  .header{
    background:#fff;
    padding:16px 20px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:0 2px 8px rgba(0,0,0,0.04);
    position:sticky;
    top:0;
    z-index:10;
  }
  .header h1{
    font-size:18px;
    font-weight:600;
    color:#111;
  }
  .cart{
    font-size:20px;
    color:#007AFF;
  }
  .admin-btn {
    background: #FF3B30;
    color: #fff;
    border: none;
    padding: 6px 10px;
    border-radius: 8px;
    font-size: 12px;
    margin-left: 8px;
    cursor: pointer;
  }

  .tabs{
    display:flex;
    overflow-x:auto;
    gap:10px;
    padding:12px 16px;
    background:#fff;
    scrollbar-width:none;
  }
  .tabs::-webkit-scrollbar{display:none}
  .tabs button{
    white-space:nowrap;
    padding:9px 15px;
    border-radius:20px;
    border:none;
    background:#F1F5F9;
    color:#555;
    font-size:14px;
    cursor:pointer;
    transition:0.2s;
  }
  .tabs button.active{
    background:#007AFF;
    color:#fff;
  }

  .page{display:none}
  .page.active{display:block}
  .item{
    background:#fff;
    border-radius:14px;
    padding:16px;
    margin:0 12px 10px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:0 1px 4px rgba(0,0,0,0.03);
  }
  .item .name{
    font-size:15px;
    color:#222;
  }
  .check{
    width:22px;
    height:22px;
    border:2px solid #D1D5DB;
    border-radius:6px;
    display:grid;
    place-items:center;
    cursor:pointer;
    transition:0.2s;
  }
  .check.checked{
    background:#007AFF;
    border-color:#007AFF;
  }
  .check.checked::after{
    content:"✓";
    font-size:12px;
    color:#fff;
  }

  .category-title{
    padding:14px 18px 10px;
    font-size:14px;
    color:#444;
    font-weight:700;
  }

  .bottom{
    position:fixed;
    bottom:0;
    left:50%;
    transform:translateX(-50%);
    width:100%;
    max-width:480px;
    background:#fff;
    padding:14px 20px;
    box-shadow:0 -2px 10px rgba(0,0,0,0.06);
    display:flex;
    justify-content:space-between;
    align-items:center;
  }
  .count{
    color:#444;
    font-size:15px;
  }
  .submit{
    background:#007AFF;
    color:white;
    border:none;
    padding:11px 20px;
    border-radius:12px;
    font-size:15px;
    cursor:pointer;
  }

  .order-container{
    padding:20px;
  }
  .order-title{
    font-size:18px;
    font-weight:600;
    text-align:center;
    margin-bottom:20px;
    color:#111;
  }
  .order-item{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:12px;
    background:#fff;
    border-radius:12px;
    margin-bottom:8px;
  }
  .order-name{
    width:35%;
  }
  .price-input{
    width:60px;
    padding:6px;
    border:1px solid #ddd;
    border-radius:6px;
    text-align:center;
  }
  .qty-group{
    display:flex;
    align-items:center;
    gap:8px;
  }
  .qty-btn{
    width:28px;
    height:28px;
    border:none;
    background:#F1F5F9;
    border-radius:6px;
    cursor:pointer;
  }
  .total-box{
    margin-top:16px;
    padding:12px;
    background:#fff;
    border-radius:12px;
    text-align:right;
    font-size:16px;
    font-weight:bold;
  }
  .action-buttons{
    display:flex;
    gap:10px;
    margin-top:12px;
  }
  .print-btn,.save-btn,.back-btn{
    flex:1;
    padding:12px;
    border-radius:10px;
    border:none;
    cursor:pointer;
  }
  .print-btn{
    background:#28a745;
    color:#fff;
  }
  .save-btn{
    background:#007AFF;
    color:#fff;
  }
  .back-btn{
    background:#F1F5F9;
  }

  .admin-page {
    padding: 20px;
  }
  .admin-section {
    background: #fff;
    border-radius: 14px;
    padding: 16px;
    margin-bottom: 16px;
  }
  .admin-section h3 {
    font-size: 16px;
    margin-bottom: 12px;
  }
  .admin-input, .admin-select {
    width: 100%;
    padding: 12px;
    border-radius: 10px;
    border: 1px solid #ddd;
    margin-bottom: 10px;
    font-size: 15px;
  }
  .btn-blue {
    background: #007AFF;
    color: #fff;
    width: 100%;
    padding: 12px;
    border-radius: 10px;
    border: none;
    margin-bottom: 8px;
    cursor: pointer;
  }
  .btn-red {
    background: #FF3B30;
    color: #fff;
    width: 100%;
    padding: 12px;
    border-radius: 10px;
    border: none;
    cursor: pointer;
  }
</style>
</head>
<body>

<div id="menuPage" class="page active">
  <div class="header">
    <h1>自助点餐</h1>
    <div style="display:flex;align-items:center">
      <div class="cart">🛒 <span id="total">0</span></div>
      <button class="admin-btn" onclick="goToAdmin()">管理</button>
    </div>
  </div>

  <div class="tabs" id="tabContainer">
    <button class="active" onclick="showPage('salad')">沙拉</button>
    <button onclick="showPage('cold')">冷菜</button>
    <button onclick="showPage('sushi')">寿司</button>
    <button onclick="showPage('seafood')">海鲜</button>
    <button onclick="showPage('sashimi')">刺身</button>
    <button onclick="showPage('hot')">热菜</button>
    <button onclick="showPage('rice')">主食</button>
    <button onclick="showPage('cook')">煎扒烧烤</button>
    <button onclick="showPage('fruit')">水果</button>
    <button onclick="showPage('drink')">饮料</button>
  </div>

  <div id="content">
    <div id="salad" class="page active">
      <div class="category-title">沙拉基底</div>
      <div class="item"><div class="name">红叶生菜</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">苦菊</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">球生菜</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">罗马生菜</div><div class="check" onclick="toggle(this)"></div></div>

      <div class="category-title">配料（任选4款）</div>
      <div class="item"><div class="name">玉米粒</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">红腰豆</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">黄瓜片</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">黑橄榄</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">青橄榄</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">圣女果</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">培根丁</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">面包丁</div><div class="check" onclick="toggle(this)"></div></div>

      <div class="category-title">加料选配</div>
      <div class="item"><div class="name">烟熏鸡肉</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">烟熏鸭肉</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">芒果丁</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">草莓</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">无花果</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">蓝莓</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">牛肉片</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">牛油果</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">腰果</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">核桃</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">西班牙火腿</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">烟熏三文鱼</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">虾仁</div><div class="check" onclick="toggle(this)"></div></div>

      <div class="category-title">沙拉汁</div>
      <div class="item"><div class="name">千岛汁</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">意大利油醋汁</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">芝麻汁</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">凯撒汁</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">酸奶</div><div class="check" onclick="toggle(this)"></div></div>
    </div>

    <div id="cold" class="page">
      <div class="category-title">中式冷菜</div>
      <div class="item"><div class="name">海带菜</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">木耳</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">海蜇</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">柠檬鸡爪</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">虎皮凤爪</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">酱牛肉</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">白切鸡</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">桂花糖藕</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">鸭舌</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">熏鱼</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">藤椒毛肚</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">泰式柠檬虾</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">酱鸭</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">盐水鸭</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">拌黄瓜</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">糖醋里脊</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">捞汁小海鲜</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">芥末章鱼</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">芥末螺片</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">五香牛肉片</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">手撕鸡</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">卤鸭掌</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">卤牛肚</div><div class="check" onclick="toggle(this)"></div></div>

      <div class="category-title">西式冷菜</div>
      <div class="item"><div class="name">冷切肉拼盘</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">水果沙拉</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">樱桃鹅肝</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">火腿三明治</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">芒果鸭胸</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">烟熏三文鱼塔塔</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">西班牙火腿配蜜瓜</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">金枪鱼塔塔配牛油果</div><div class="check" onclick="toggle(this)"></div></div>
    </div>

    <div id="sushi" class="page">
      <div class="item"><div class="name">寿司船</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">樱花寿司</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">军舰寿司</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">手握寿司</div><div class="check" onclick="toggle(this)"></div></div>
    </div>

    <div id="seafood" class="page">
      <div class="category-title">海鲜</div>
      <div class="item"><div class="name">南美甜虾</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">白灼基围虾</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">梭子蟹</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">白葡萄酒烩青口</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">香辣青蟹</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">白灼兰花蟹</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">清蒸帝王蟹腿</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">清蒸小青龙</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">葱油鱿鱼</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">高压锅生蚝</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">进口生食生蚝</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">葱爆珍宝蟹</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">蒜蓉粉丝蒸扇贝</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">葱油鲍鱼</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">椒盐皮皮虾</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">红烧鳗鱼</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">蒜蓉粉丝墨鱼仔</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">香辣花蛤</div><div class="check" onclick="toggle(this)"></div></div>

      <div class="category-title">河鲜</div>
      <div class="item"><div class="name">大闸蟹</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">河虾</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">太湖白虾</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">沼虾</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">鳝鱼</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">甲鱼</div><div class="check" onclick="toggle(this)"></div></div>
    </div>

    <div id="sashimi" class="page">
      <div class="item"><div class="name">三文鱼</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">金枪鱼</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">牡丹虾</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">北极甜虾</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">西陵鱼籽</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">深海鲷鱼</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">醋青鱼</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">章鱼足</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">北极贝</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">象拔蚌</div><div class="check" onclick="toggle(this)"></div></div>

      <div class="category-title">刺身小料</div>
      <div class="item"><div class="name">酱油</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">醋</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">海鲜汁</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">柠檬角</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">芥末膏</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">日式泡姜</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">芥末</div><div class="check" onclick="toggle(this)"></div></div>
    </div>

    <div id="hot" class="page">
      <div class="category-title">中式热菜</div>
      <div class="item"><div class="name">爆炒大虾</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">蜜汁鸭肉</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">本帮红烧肉</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">红烧羊肉</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">红烩牛肉</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">爆炒鸡肉</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">黑椒牛仔骨</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">红烧甲鱼</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">慢烤鸡中翅</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">红烧大肠</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">香辣小龙虾</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">糖醋排骨</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">烤全羊</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">孜然羊排</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">香辣烤猪蹄</div><div class="check" onclick="toggle(this)"></div></div>

      <div class="category-title">中式小炒</div>
      <div class="item"><div class="name">芦笋炒虾仁</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">芦笋百合羊肚菌</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">青豆玉米炒虾仁</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">西蓝花炒山药</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">春三鲜</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">菜椒炒三菇</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">芦笋炒牛肉</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">西芹百合</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">荷塘小炒</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">莴笋山药炒肉片</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">香菜炒牛肉</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">青椒炒猪肚</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">茶树菇炒腊肉</div><div class="check" onclick="toggle(this)"></div></div>
    </div>

    <div id="rice" class="page">
      <div class="category-title">主食</div>
      <div class="item"><div class="name">时蔬炒饭</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">海苔拌饭</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">白米饭</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">蒸南瓜</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">蒸芋头</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">蒸玉米</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">蒸红薯</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">小米粥</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">黑椒意大利面</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">法棍/餐包</div><div class="check" onclick="toggle(this)"></div></div>

      <div class="category-title">汤品</div>
      <div class="item"><div class="name">玉米排骨汤</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">海带排骨汤</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">鸡肉菌菇汤</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">排骨菌菇汤</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">酒酿丸子羹</div><div class="check" onclick="toggle(this)"></div></div>
    </div>

    <div id="cook" class="page">
      <div class="category-title">煎扒档</div>
      <div class="item"><div class="name">牛排</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">羊排</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">鸡肉</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">秋刀鱼</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">小黄鱼</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">鲳鱼</div><div class="check" onclick="toggle(this)"></div></div>

      <div class="category-title">烧烤档</div>
      <div class="item"><div class="name">蒜蓉烤生蚝</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">五花肉</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">羊肉串</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">牛肉串</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">鱿鱼须</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">香肠</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">鸡翅中</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">大虾</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">香菇</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">年糕</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">面筋</div><div class="check" onclick="toggle(this)"></div></div>

      <div class="category-title">炸物</div>
      <div class="item"><div class="name">炸薯条</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">炸鸡米花</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">炸鸡块</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">炸鸡翅</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">鳕鱼</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">鸡腿</div><div class="check" onclick="toggle(this)"></div></div>
    </div>

    <div id="fruit" class="page">
      <div class="item"><div class="name">橙子</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">香蕉</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">圣女果</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">龙眼</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">草莓</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">荔枝</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">哈密瓜</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">车厘子</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">冬枣</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">提子</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">蓝莓</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">金桔</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">人参果</div><div class="check" onclick="toggle(this)"></div></div>
    </div>

    <div id="drink" class="page">
      <div class="item"><div class="name">果茶桶</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">红茶桶</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">现磨咖啡</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">汽水桶</div><div class="check" onclick="toggle(this)"></div></div>
      <div class="item"><div class="name">奶茶桶</div><div class="check" onclick="toggle(this)"></div></div>
    </div>
  </div>

  <div class="bottom">
    <div class="count" id="countText">已选：0 份</div>
    <button class="submit" onclick="goToOrderPage()">提交订单</button>
  </div>
</div>

<div id="orderPage" class="page">
  <div class="order-container">
    <div class="order-title">订单确认</div>
    <div id="orderItemsList"></div>
    <div class="total-box">合计：¥<span id="totalPrice">0.00</span></div>
    <div class="action-buttons">
      <button class="print-btn" onclick="printOrder()">打印订单</button>
      <button class="save-btn" onclick="saveOrderToExcel()">保存表格</button>
      <button class="back-btn" onclick="backToMenu()">返回点餐</button>
    </div>
  </div>
</div>

<div id="adminPage" class="page">
  <div class="admin-page">
    <div class="admin-section">
      <h3>新增菜品（多级分类）</h3>
      <input class="admin-input" id="newDishName" placeholder="菜品名称">
      <select class="admin-select" id="mainCatSelect"></select>
      <select class="admin-select" id="subCatSelect"></select>
      <button class="btn-blue" onclick="addDish()">添加菜品</button>
    </div>

    <div class="admin-section">
      <h3>删除菜品</h3>
      <select class="admin-select" id="delDishSelect"></select>
      <button class="btn-red" onclick="deleteDish()">删除</button>
    </div>

    <div class="admin-section">
      <h3>新增二级分类</h3>
      <select class="admin-select" id="newSubMainCat"></select>
      <input class="admin-input" id="newSubName" placeholder="分类名">
      <button class="btn-blue" onclick="addSubCategory()">添加分类</button>
    </div>

    <button class="back-btn" onclick="backToMenuFromAdmin()">返回点餐</button>
  </div>
</div>

<script>
let orderData = [];

let categoryData = {
  salad: { name: "沙拉", sub: ["沙拉基底", "配料（任选4款）", "加料选配", "沙拉汁"] },
  cold: { name: "冷菜", sub: ["中式冷菜", "西式冷菜"] },
  sushi: { name: "寿司", sub: ["寿司"] },
  seafood: { name: "海鲜", sub: ["海鲜", "河鲜"] },
  sashimi: { name: "刺身", sub: ["刺身", "刺身小料"] },
  hot: { name: "热菜", sub: ["中式热菜", "中式小炒"] },
  rice: { name: "主食", sub: ["主食", "汤品"] },
  cook: { name: "煎扒烧烤", sub: ["煎扒档", "烧烤档", "炸物"] },
  fruit: { name: "水果", sub: ["水果"] },
  drink: { name: "饮料", sub: ["饮料"] }
};

// 点餐
function toggle(el) {
  el.classList.toggle('checked');
  const count = document.querySelectorAll('.check.checked').length;
  document.getElementById('total').innerText = count;
  document.getElementById('countText').innerText = `已选：${count} 份`;
}

function showPage(id) {
  document.querySelectorAll('#content .page').forEach(p => p.classList.remove('active'));
  document.getElementById(id).classList.add('active');
  document.querySelectorAll('.tabs button').forEach(b => b.classList.remove('active'));
  event.target.classList.add('active');
}

function goToOrderPage() {
  const items = [...document.querySelectorAll('.check.checked')].map(i => ({
    name: i.previousElementSibling.innerText, qty:1, price:0
  }));
  if(!items.length){alert('请选择菜品');return;}
  orderData = items;
  renderOrderPage();
  calcTotal();
  document.getElementById('menuPage').classList.remove('active');
  document.getElementById('orderPage').classList.add('active');
}

// 渲染订单（带价格）
function renderOrderPage(){
  let html='';
  orderData.forEach((item,i)=>{
    html+=`
    <div class="order-item">
      <div class="order-name">${item.name}</div>
      <div class="qty-group">
        <button class="qty-btn" onclick="changeQty(${i},-1)">-</button>
        <div>${item.qty}</div>
        <button class="qty-btn" onclick="changeQty(${i},1)">+</button>
      </div>
      <input type="number" class="price-input" placeholder="单价" value="${item.price}" oninput="updatePrice(${i},this.value)">
    </div>`;
  });
  document.getElementById('orderItemsList').innerHTML = html;
}

function updatePrice(index,val){
  orderData[index].price = parseFloat(val)||0;
  calcTotal();
}

function changeQty(i,n){
  let v = orderData[i].qty + n;
  if(v<1) return;
  orderData[i].qty = v;
  renderOrderPage();
  calcTotal();
}

// 自动计算总价
function calcTotal(){
  let total = orderData.reduce((sum,item)=>sum + item.qty * item.price, 0);
  document.getElementById('totalPrice').innerText = total.toFixed(2);
}

// 打印
function printOrder(){
  window.print();
}

// 保存并下载表格
function saveOrderToExcel(){
  if(!orderData.length){alert('无订单');return;}
  let csv = "\uFEFF菜品名称,数量,单价,小计\n";
  orderData.forEach(item=>{
    let subtotal = (item.qty * item.price).toFixed(2);
    csv += `${item.name},${item.qty},${item.price},${subtotal}\n`;
  });
  let total = orderData.reduce((s,i)=>s+i.qty*i.price,0).toFixed(2);
  csv += `合计,,,${total}`;
  
  let a = document.createElement('a');
  a.href = URL.createObjectURL(new Blob([csv], {type:'text/csv'}));
  a.download = "订单.csv";
  a.click();
}

function backToMenu(){
  document.getElementById('o