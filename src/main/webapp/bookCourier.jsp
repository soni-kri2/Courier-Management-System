<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Courier</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body style="background:#f5f5f5;">

<!-- Navbar -->
<nav class="navbar navbar-dark bg-dark">
  <div class="container-fluid">
    <span class="navbar-brand">🚚 CourierMS</span>
  </div>
</nav>

<div class="container mt-5">
  <div class="card shadow p-4">

    <h3 class="text-center mb-4">📦 Book Courier</h3>

    <!-- ✅ FIXED FORM ACTION -->
    <form action="<%=request.getContextPath()%>/bookCourier" method="post">

      <!-- Receiver Details -->
      <h5 class="mb-3">Receiver Details</h5>

      <div class="row">
        <div class="col-md-4">
          <label>Name</label>
          <input type="text" name="receiverName" class="form-control" required>
        </div>

        <div class="col-md-4">
          <label>Phone</label>
          <!-- ✅ FIXED NAME -->
          <input type="text" name="receiverPhone" class="form-control" required>
        </div>

        <div class="col-md-4">
          <label>Pincode</label>
          <input type="text" name="pincode" class="form-control">
        </div>
      </div>

      <br>

      <!-- ✅ FIXED NAME -->
      <label>Delivery Address</label>
      <input type="text" name="receiverAddress" class="form-control" required>

      <br>

      <!-- Package -->
      <h5 class="mb-3">Package Details</h5>

      <div class="row">
        <div class="col-md-4">
          <label>Weight (kg)</label>
          <input type="number" id="weight" name="weight" class="form-control" onkeyup="calc()" required>
        </div>

        <div class="col-md-4">
          <label>Amount (₹)</label>
          <input type="text" id="amount" class="form-control" readonly>
        </div>

        <div class="col-md-4">
          <label>Type</label>
          <select name="packageType" class="form-control">
            <option>Document</option>
            <option>Parcel</option>
          </select>
        </div>
      </div>

      <br>

      <!-- Payment -->
      <div class="row">
        <div class="col-md-6">
          <label>Delivery Type</label>
          <select name="deliveryType" class="form-control">
            <option>Normal</option>
            <option>Express</option>
          </select>
        </div>

        <div class="col-md-6">
          <label>Payment Mode</label>
          <select name="payment" class="form-control">
            <option>Cash</option>
            <option>Online</option>
          </select>
        </div>
      </div>

      <br>

      <!-- Instructions -->
      <label>Instructions</label>
      <textarea name="note" class="form-control"></textarea>

      <br>

      <!-- Submit -->
      <div class="text-center">
        <button onclick="this.innerText='Processing...'" class="btn btn-success px-5">
          🚀 Book Courier
        </button>
      </div>

    </form>

  </div>
</div>

<!-- JS -->
<script>
function calc(){
  let w = document.getElementById("weight").value;
  document.getElementById("amount").value = (w * 50) + 100;
}
</script>

</body>
</html>