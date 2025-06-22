
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<%@ page import="java.util.*" %>
<%
    Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
    int itemCount = 0;
    if (cart != null) {
        for (int qty : cart.values()) {
            itemCount += qty;
        }
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>food</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            background-image: url('https://wallpapercave.com/wp/wp10615929.jpg');
        }


        .nav-bar {
            display: flex;
            justify-content: center;
            background-color: #fff;
            border-bottom: 1px solid #ddd;
        }

        .nav-bar a {
            padding: 15px 25px;
            text-decoration: none;
            color: #000;
            font-weight: 500;
            border-right: 1px solid #eee;
            transition: background-color 0.3s;
        }
        .cart-btn {
            position: relative;
            font-weight: bold;
            color: #283da2;
            padding: 15px 25px;
            text-decoration: none;
            transition: background-color 0.3s;
            border-right: 1px solid #eee;
        }

        .cart-btn:hover {
            background-color: #3b488c;
            color: white;
        }

        .cart-badge {
            background-color: #ff3b3b;
            color: white;
            border-radius: 50%;
            padding: 2px 8px;
            font-size: 12px;
            margin-left: 5px;
        }


        .nav-bar a:last-child {
            border-right: none;
        }

        .nav-bar a:hover {
            background-color: #3b488c;
        }

        .nav-bar a.active {
            background-color: #eee;
            color: #000;
            font-weight: bold;
        }


        .menu-container {
            max-width: 1200px;
            margin: auto;
            padding: 40px 20px;
        }

        .menu-title {
            text-align: center;
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 40px;
            color: #333;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
        }

        .menu-card {
            background-color: #fff;
            border-radius: 20px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.05);
            overflow: hidden;
            text-align: center;
            padding: 20px;
            transition: transform 0.3s ease;
        }

        .menu-card:hover {
            transform: translateY(-5px);
        }

        .menu-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 15px;
        }

        .menu-card h3 {
            margin: 15px 0 5px;
            font-size: 20px;
            color: #222;
        }

        .menu-card p {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .price {
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 15px;
            color: #00c853;
        }

        .add-btn {
            background-color: #283da2;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .add-btn:hover {
            background-color: #3b488c;
        }
    </style>
</head>
<body>


<nav class="nav-bar">
    <a href="#">Foods</a>
    <a href="view-cart" class="cart-btn">
        🛒 Cart <span class="cart-badge"><%= itemCount %></span>
    </a>
</nav>



<div class="menu-container">
    <div class="menu-title"> foods</div>

    <div class="menu-grid">
        <div class="menu-card">
            <img src="https://img.freepik.com/free-photo/view-3d-cinema-popcorn_23-2151069368.jpg?t=st=1744080027~exp=1744083627~hmac=da35888a1c85a8e4f32b0d5be1a5f04a14f3016ef083c2cf829c3e45b0c1b149&w=826" alt="Popcorn">
            <h3>Butter Popcorn</h3>
            <p>Golden buttery popcorn freshly popped and served warm.</p>
            <div class="price">Rs. 400</div>
            <form action="<%= request.getContextPath() %>/add-to-cart" method="post">
            <input type="hidden" name="itemName" value="Butter Popcorn"/>
                <input type="hidden" name="price" value="400"/>
                <button type="submit" class="add-btn">Add to Order</button>
            </form>

        </div>

        <div class="menu-card">
            <img src="https://img.freepik.com/free-photo/delicious-burger-with-many-ingredients-isolated-white-background-tasty-cheeseburger-splash-sauce_90220-1266.jpg?t=st=1744002713~exp=1744006313~hmac=8ac75ddbd1bfa9ad712e144d1385454b888af17a55ca2dac0980c473d7c6212b&w=826" alt="Burger">
            <h3>Beef Burger</h3>
            <p>Juicy grilled beef patty, lettuce, tomato, cheese, and sauce.</p>
            <div class="price">Rs. 790</div>
            <form action="<%= request.getContextPath() %>/add-to-cart" method="post">
            <input type="hidden" name="itemName" value="Beef Burger"/>
                <input type="hidden" name="price" value="760"/>
                <button type="submit" class="add-btn">Add to Order</button>
            </form>

        </div>

        <div class="menu-card">
            <img src="https://img.freepik.com/free-photo/delicious-crispy-table_23-2150857866.jpg?t=st=1744080425~exp=1744084025~hmac=198f04f03edefd497a7d11a621a1b54b050bbe91b88dab3550752aad5d0e7118&w=1380" alt="">
            <h3>Crispy chiken</h3>
            <p>Classic margherita pizza loaded with cheese and herbs.</p>
            <div class="price">Rs. 1,150</div>
            <form action="<%= request.getContextPath() %>/add-to-cart" method="post">
            <input type="hidden" name="itemName" value="Cheese Pizza"/>
                <input type="hidden" name="price" value="1150"/>
                <button type="submit" class="add-btn">Add to Order</button>
            </form>

        </div>

        <div class="menu-card">
            <img src="https://img.freepik.com/premium-photo/kyiv-ukraine-september-18-2017-can-cocacola-white-background_392895-578581.jpg?w=740" alt="cocacola">
            <h3>Coca-Cola</h3>
            <p>Classic margherita pizza loaded with cheese and herbs.</p>
            <div class="price">Rs. 1,150</div>
            <form action="<%= request.getContextPath() %>/add-to-cart" method="post">
            <input type="hidden" name="itemName" value="Crispy chiken"/>
                <input type="hidden" name="price" value="1150"/>
                <button type="submit" class="add-btn">Add to Order</button>
            </form>

        </div>

        <div class="menu-card">
            <img src="https://img.freepik.com/free-photo/top-view-pepperoni-pizza-with-mushroom-sausages-bell-pepper-olive-corn-black-wooden_141793-2158.jpg?t=st=1744080206~exp=1744083806~hmac=9fbac848c724b7999cc7ca2db9e71a2d8d0064769cc6b624beaae8b6f997a58e&w=1380" alt="Pizza">
            <h3>Cheese Pizza</h3>
            <p>Classic margherita pizza loaded with cheese and herbs.</p>
            <div class="price">Rs. 1,150</div>
            <form action="<%= request.getContextPath() %>/add-to-cart" method="post">
            <input type="hidden" name="itemName" value="hchhg"/>
                <input type="hidden" name="price" value="1200"/>
                <button type="submit" class="add-btn">Add to Order</button>
            </form>

        </div>

        <div class="menu-card">
            <img src="https://img.freepik.com/free-vector/potato-chips-bag-ad_52683-35118.jpg?t=st=1744087319~exp=1744090919~hmac=da942c9c0847029e33a81ee9f778607b05bdc667732cd499749792332738cf66&w=1380" alt="chips">
            <h3>potato chips</h3>
            <p>Classic margherita pizza loaded with cheese and herbs.</p>
            <div class="price">Rs. 1,150</div>
            <form action="<%= request.getContextPath() %>/add-to-cart" method="post">
            <input type="hidden" name="itemName" value="Butter Popcorn"/>
                <input type="hidden" name="price" value="400"/>
                <button type="submit" class="add-btn">Add to Order</button>
            </form>

        </div>

        <div class="menu-card">
            <img src="https://img.freepik.com/free-photo/club-sandwich-with-side-french-fries_140725-1744.jpg?t=st=1744089338~exp=1744092938~hmac=e15d2a8d80f1da273af15cf9391988573854adb9d228b7af08d0280eaaae0416&w=1380" alt="sandwitch">
            <h3>sandwitch</h3>
            <p>Classic margherita pizza loaded with cheese and herbs.</p>
            <div class="price">Rs. 1,150</div>
            <form action="<%= request.getContextPath() %>/add-to-cart" method="post">
            <input type="hidden" name="itemName" value="Butter Popcorn"/>
                <input type="hidden" name="price" value="400"/>
                <button type="submit" class="add-btn">Add to Order</button>
            </form>


        </div>

    </div>
</div>
</body>
</html>
