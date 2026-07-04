<%@ page import="java.util.*, com.courier.model.Courier" %>
<%
List<Courier> list = (List<Courier>) request.getAttribute("couriers");

// Stats calculation
int total = 0, delivered = 0, inTransit = 0, pending = 0;
double totalRevenue = 0;

if (list != null) {
    total = list.size();
    for (Courier c : list) {
        String status = c.getStatus() != null ? c.getStatus().toLowerCase() : "";
        if (status.contains("deliver")) delivered++;
        else if (status.contains("transit") || status.contains("shipped")) inTransit++;
        else pending++;
        totalRevenue += c.getAmount();
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard — CourierMS</title>

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
  :root {
    --bg:        #f4f6f9;        /* light background */
    --surface:   #ffffff;        /* card background */
    --surface2:  #eef2ff;        /* soft section bg */
    --border:    #dbeafe;        /* light border */

    --accent:    #2563eb;        /* primary blue */
    --accent2:   #1e40af;        /* dark blue */

    --blue:      #2563eb;        /* main theme */
    --green:     #22c55e;        /* success */
    --yellow:    #facc15;        /* warning */
    --red:       #dc2626;        /* danger */

    --text:      #1e293b;        /* dark text */
    --muted:     #64748b;        /* secondary text */
    --font-head: 'Syne', sans-serif;
    --font-body: 'DM Sans', sans-serif;
  }

  * { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    background: var(--bg);
    color: var(--text);
    font-family: var(--font-body);
    font-size: 14px;
    min-height: 100vh;
    display: flex;
  }

  /* ─── Sidebar ─────────────────────────── */
  .sidebar {
    width: 260px;
    min-height: 100vh;
    background: var(--surface);
    border-right: 1px solid var(--border);
    display: flex;
    flex-direction: column;
    position: fixed;
    top: 0; left: 0;
    z-index: 100;
    transition: transform .3s ease;
  }

  .sidebar-logo {
    padding: 28px 24px 20px;
    border-bottom: 1px solid var(--border);
    display: flex;
    align-items: center;
    gap: 12px;
  }

  .logo-icon {
    width: 42px; height: 42px;
    background: var(--accent);
    border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    font-size: 18px;
    color: #fff;
    flex-shrink: 0;
  }

  .logo-text {
    font-family: var(--font-head);
    font-weight: 800;
    font-size: 20px;
    letter-spacing: -0.5px;
  }

  .logo-text span { color: var(--accent); }

  .sidebar-section {
    padding: 20px 14px 6px;
    font-size: 10px;
    font-weight: 600;
    letter-spacing: 1.5px;
    color: var(--muted);
    text-transform: uppercase;
  }

  .nav-link-custom {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 11px 14px;
    border-radius: 10px;
    color: var(--muted);
    text-decoration: none;
    font-weight: 500;
    margin: 2px 8px;
    transition: background .2s, color .2s;
    font-size: 14px;
  }

  .nav-link-custom i {
    width: 20px;
    text-align: center;
    font-size: 15px;
  }

  .nav-link-custom:hover,
  .nav-link-custom.active {
    background: var(--surface2);
    color: var(--text);
  }

  .nav-link-custom.active {
    color: var(--accent);
    background: rgba(249,115,22,.1);
  }

  .nav-link-custom.active i { color: var(--accent); }

  .sidebar-footer {
    margin-top: auto;
    padding: 16px;
    border-top: 1px solid var(--border);
  }

  .user-card {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 10px 12px;
    background: var(--surface2);
    border-radius: 12px;
    cursor: pointer;
  }

  .avatar {
    width: 36px; height: 36px;
    background: linear-gradient(135deg, var(--accent), var(--blue));
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-weight: 700;
    font-size: 14px;
    flex-shrink: 0;
    color: #fff;
  }

  .user-info .name { font-weight: 600; font-size: 13px; }
  .user-info .role { color: var(--muted); font-size: 11px; }

  .btn-logout {
    margin-left: auto;
    color: var(--muted);
    background: none;
    border: none;
    font-size: 14px;
    cursor: pointer;
    transition: color .2s;
  }
  .btn-logout:hover { color: var(--red); }

  /* ─── Main ─────────────────────────────── */
  .main-content {
    margin-left: 260px;
    flex: 1;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
  }

  /* ─── Topbar ────────────────────────────── */
  .topbar {
    background: var(--surface);
    border-bottom: 1px solid var(--border);
    padding: 16px 28px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: sticky; top: 0; z-index: 50;
  }

  .topbar-title {
    font-family: var(--font-head);
    font-size: 22px;
    font-weight: 700;
  }

  .topbar-actions { display: flex; gap: 10px; align-items: center; }

  .btn-primary-custom {
    background: var(--accent);
    color: #fff;
    border: none;
    padding: 9px 18px;
    border-radius: 9px;
    font-weight: 600;
    font-size: 13px;
    cursor: pointer;
    display: flex; align-items: center; gap: 8px;
    text-decoration: none;
    transition: background .2s, transform .15s;
  }
  .btn-primary-custom:hover { background: var(--accent2); color:#fff; transform: translateY(-1px); }

  .btn-outline-custom {
    background: transparent;
    color: var(--muted);
    border: 1px solid var(--border);
    padding: 9px 16px;
    border-radius: 9px;
    font-weight: 500;
    font-size: 13px;
    cursor: pointer;
    display: flex; align-items: center; gap: 8px;
    text-decoration: none;
    transition: all .2s;
  }
  .btn-outline-custom:hover { border-color: var(--accent); color: var(--accent); }

  /* ─── Page body ─────────────────────────── */
  .page-body { padding: 28px; flex: 1; }

  /* ─── Stats Grid ────────────────────────── */
  .stats-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 18px;
    margin-bottom: 28px;
  }

  .stat-card {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 16px;
    padding: 22px;
    display: flex;
    flex-direction: column;
    gap: 14px;
    position: relative;
    overflow: hidden;
    transition: transform .2s, border-color .2s;
  }

  .stat-card:hover { transform: translateY(-3px); border-color: var(--accent); }

  .stat-card::before {
    content: '';
    position: absolute;
    top: 0; right: 0;
    width: 80px; height: 80px;
    border-radius: 0 16px 0 80px;
    opacity: .07;
  }

  .stat-card.total::before  { background: var(--accent); }
  .stat-card.transit::before{ background: var(--blue); }
  .stat-card.done::before   { background: var(--green); }
  .stat-card.revenue::before{ background: var(--yellow); }

  .stat-icon {
    width: 42px; height: 42px;
    border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    font-size: 17px;
  }

  .stat-icon.orange { background: rgba(249,115,22,.15); color: var(--accent); }
  .stat-icon.blue   { background: rgba(59,130,246,.15); color: var(--blue); }
  .stat-icon.green  { background: rgba(34,197,94,.15);  color: var(--green); }
  .stat-icon.yellow { background: rgba(234,179,8,.15);  color: var(--yellow); }

  .stat-value {
    font-family: var(--font-head);
    font-size: 32px;
    font-weight: 800;
    line-height: 1;
  }

  .stat-label { color: var(--muted); font-size: 13px; font-weight: 500; }

  .stat-change {
    font-size: 12px;
    display: flex; align-items: center; gap: 4px;
    color: var(--green);
    font-weight: 500;
  }

  /* ─── Table Card ────────────────────────── */
  .card-custom {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 16px;
    overflow: hidden;
  }

  .card-header-custom {
    padding: 20px 24px;
    border-bottom: 1px solid var(--border);
    display: flex;
    align-items: center;
    justify-content: space-between;
  }

  .card-title {
    font-family: var(--font-head);
    font-size: 17px;
    font-weight: 700;
  }

  .search-box {
    background: var(--surface2);
    border: 1px solid var(--border);
    border-radius: 9px;
    padding: 8px 14px;
    color: var(--text);
    font-size: 13px;
    width: 220px;
    outline: none;
    transition: border-color .2s;
  }
  .search-box:focus { border-color: var(--accent); }
  .search-box::placeholder { color: var(--muted); }

  /* Table */
  .table-custom {
    width: 100%;
    border-collapse: collapse;
  }

  .table-custom thead th {
    background: var(--surface2);
    color: var(--muted);
    font-size: 11px;
    font-weight: 600;
    letter-spacing: 1px;
    text-transform: uppercase;
    padding: 13px 20px;
    border-bottom: 1px solid var(--border);
    white-space: nowrap;
  }

  .table-custom tbody tr {
    border-bottom: 1px solid var(--border);
    transition: background .15s;
  }
  .table-custom tbody tr:last-child { border-bottom: none; }
  .table-custom tbody tr:hover { background: var(--surface2); }

  .table-custom tbody td {
    padding: 5px 10px;
    font-size: 13.5px;
    vertical-align: middle;
  }

  .tracking-no {
    font-family: monospace;
    font-size: 12px;
    background: var(--surface2);
    padding: 4px 10px;
    border-radius: 6px;
    color: var(--accent);
    font-weight: 600;
    letter-spacing: .5px;
    border: 1px solid var(--border);
  }

  /* Badges */
  .badge-custom {
    display: inline-flex; align-items: center; gap: 5px;
    padding: 4px 12px;
    border-radius: 999px;
    font-size: 11.5px;
    font-weight: 600;
  }
  .badge-custom .dot {
    width: 6px; height: 6px;
    border-radius: 50%;
  }

  .badge-delivered { background: rgba(34,197,94,.12); color: var(--green); }
  .badge-delivered .dot { background: var(--green); }

  .badge-transit   { background: rgba(59,130,246,.12); color: var(--blue); }
  .badge-transit .dot   { background: var(--blue); }

  .badge-pending   { background: rgba(234,179,8,.12); color: var(--yellow); }
  .badge-pending .dot   { background: var(--yellow); }

  .badge-default   { background: rgba(100,116,139,.12); color: var(--muted); }
  .badge-default .dot   { background: var(--muted); }

  /* Action Buttons */
  .btn-table {
    padding: 6px 12px;
    border-radius: 7px;
    font-size: 12px;
    font-weight: 600;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 5px;
    border: none;
    cursor: pointer;
    transition: opacity .2s, transform .15s;
  }
  .btn-table:hover { opacity: .85; transform: translateY(-1px); }

  .btn-track  { background: rgba(59,130,246,.15);  color: var(--blue); }
  .btn-update { background: rgba(249,115,22,.15);  color: var(--accent); }
  .btn-delete { background: rgba(239,68,68,.12);   color: var(--red); }

  /* Amount */
  .amount-cell {
    font-family: var(--font-head);
    font-weight: 700;
    color: var(--text);
  }

  /* Empty state */
  .empty-state {
    padding: 60px 20px;
    text-align: center;
  }
  .empty-state i { font-size: 48px; color: var(--border); margin-bottom: 16px; }
  .empty-state p { color: var(--muted); }

  /* Progress bar mini */
  .mini-bar-wrap { margin-top: 6px; }
  .mini-bar {
    height: 4px; border-radius: 2px; background: var(--surface2); overflow: hidden;
  }
  .mini-bar-fill { height: 100%; border-radius: 2px; }

  /* Responsive */
  @media (max-width: 1200px) {
    .stats-grid { grid-template-columns: repeat(2,1fr); }
  }

  @media (max-width: 768px) {
    .sidebar { transform: translateX(-100%); }
    .sidebar.open { transform: translateX(0); }
    .main-content { margin-left: 0; }
    .stats-grid { grid-template-columns: 1fr 1fr; }
    .topbar-title { font-size: 18px; }
  }

  @media (max-width: 480px) {
    .stats-grid { grid-template-columns: 1fr; }
  }

  /* Subtle entrance animation */
  @keyframes fadeUp {
    from { opacity:0; transform: translateY(14px); }
    to   { opacity:1; transform: translateY(0); }
  }
  .stat-card { animation: fadeUp .4s ease both; }
  .stat-card:nth-child(1) { animation-delay: .05s; }
  .stat-card:nth-child(2) { animation-delay: .10s; }
  .stat-card:nth-child(3) { animation-delay: .15s; }
  .stat-card:nth-child(4) { animation-delay: .20s; }
  .card-custom { animation: fadeUp .4s .25s ease both; }
</style>
</head>

<body>

<!-- ════════ SIDEBAR ════════ -->
<aside class="sidebar" id="sidebar">

  <div class="sidebar-logo">
    <div class="logo-icon"><i class="fa-solid fa-truck-fast"></i></div>
    <div class="logo-text">Courier<span>MS</span></div>
  </div>

  <div class="sidebar-section">Main Menu</div>

  <a href="dashboard" class="nav-link-custom active">
    <i class="fa-solid fa-gauge-high"></i> Dashboard
  </a>
  <a href="bookCourier.jsp" class="nav-link-custom">
    <i class="fa-solid fa-box"></i> Book Courier
  </a>
  <a href="trackCourier.jsp" class="nav-link-custom">
    <i class="fa-solid fa-location-dot"></i> Track Courier
  </a>
 

  <div class="sidebar-section">Support</div>

  <a href="feedback.jsp" class="nav-link-custom">
    <i class="fa-solid fa-star"></i> Feedback
  </a>
  <a href="complaint.jsp" class="nav-link-custom">
    <i class="fa-solid fa-triangle-exclamation"></i> Complaints
  </a>

  <div class="sidebar-footer">
    <div class="user-card">
      <div class="avatar">U</div>
      <div class="user-info">
        <div class="name">My Account</div>
        <div class="role">User Panel</div>
      </div>
      <a href="logout" class="btn-logout" title="Logout">
        <i class="fa-solid fa-right-from-bracket"></i>
      </a>
    </div>
  </div>

</aside>

<!-- ════════ MAIN CONTENT ════════ -->
<div class="main-content">

  <!-- ── Topbar ── -->
  <div class="topbar">
    <div class="d-flex align-items-center gap-3">
      <button class="btn-outline-custom d-md-none" onclick="toggleSidebar()">
        <i class="fa-solid fa-bars"></i>
      </button>
      <div class="topbar-title">Dashboard</div>
    </div>

    <div class="topbar-actions">
      <a href="trackCourier.jsp" class="btn-outline-custom">
        <i class="fa-solid fa-magnifying-glass"></i> Track
      </a>
      <a href="bookCourier.jsp" class="btn-primary-custom">
        <i class="fa-solid fa-plus"></i> Book Courier
      </a>
    </div>
  </div>

  <!-- ── Page Body ── -->
  <div class="page-body">

    <!-- ── Stats ── -->
    <div class="stats-grid">

      <!-- Total -->
      <div class="stat-card total">
        <div class="stat-icon orange"><i class="fa-solid fa-boxes-stacked"></i></div>
        <div>
          <div class="stat-value"><%= total %></div>
          <div class="stat-label">Total Couriers</div>
        </div>
        <div class="mini-bar-wrap">
          <div class="mini-bar">
            <div class="mini-bar-fill" style="width:100%; background: var(--accent);"></div>
          </div>
        </div>
      </div>

      <!-- In Transit -->
      <div class="stat-card transit">
        <div class="stat-icon blue"><i class="fa-solid fa-truck-moving"></i></div>
        <div>
          <div class="stat-value"><%= inTransit %></div>
          <div class="stat-label">In Transit</div>
        </div>
        <div class="mini-bar-wrap">
          <div class="mini-bar">
            <div class="mini-bar-fill"
              style="width:<%= total > 0 ? (inTransit * 100 / total) : 0 %>%;
                     background: var(--blue);"></div>
          </div>
        </div>
      </div>

      <!-- Delivered -->
      <div class="stat-card done">
        <div class="stat-icon green"><i class="fa-solid fa-circle-check"></i></div>
        <div>
          <div class="stat-value"><%= delivered %></div>
          <div class="stat-label">Delivered</div>
        </div>
        <div class="mini-bar-wrap">
          <div class="mini-bar">
            <div class="mini-bar-fill"
              style="width:<%= total > 0 ? (delivered * 100 / total) : 0 %>%;
                     background: var(--green);"></div>
          </div>
        </div>
      </div>

      <!-- Revenue -->
      <div class="stat-card revenue">
        <div class="stat-icon yellow"><i class="fa-solid fa-indian-rupee-sign"></i></div>
        <div>
          <div class="stat-value"><%= String.format("%.0f", totalRevenue) %></div>
          <div class="stat-label">Total Revenue (₹)</div>
        </div>
        <div class="stat-change">
          <i class="fa-solid fa-arrow-trend-up"></i> All time
        </div>
      </div>

    </div>
    <!-- end stats -->


    <!-- ── Courier Table ── -->
    <div class="card-custom">

      <div class="card-header-custom">
        <div>
          <div class="card-title"><i class="fa-solid fa-list-check" style="color:var(--accent);margin-right:8px;"></i>All Booked Couriers</div>
          <div style="color:var(--muted);font-size:12px;margin-top:3px;"><%= total %> record<%= total != 1 ? "s" : "" %> total</div>
        </div>
        <div class="d-flex align-items-center gap-2">
          <input type="text" class="search-box" placeholder="&#xf002;  Search couriers…" id="searchInput" oninput="filterTable()">
        </div>
      </div>

      <div style="overflow-x:auto;">
        <table class="table-custom" id="courierTable">
          <thead>
            <tr>
              <th>#</th>
              <th>Tracking No</th>
              <th>Receiver</th>
              <th>Phone</th>
              <th>Status</th>
              <th>Amount</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>

          <%
          if (list != null && !list.isEmpty()) {
              int row = 1;
              for (Courier c : list) {
                  String status = c.getStatus() != null ? c.getStatus() : "Pending";
                  String statusLower = status.toLowerCase();
                  String badgeClass = "badge-default";
                  if (statusLower.contains("deliver")) badgeClass = "badge-delivered";
                  else if (statusLower.contains("transit") || statusLower.contains("ship")) badgeClass = "badge-transit";
                  else if (statusLower.contains("pend")) badgeClass = "badge-pending";
          %>
            <tr>
              <td style="color:var(--muted);font-size:12px;"><%= row++ %></td>

              <td><span class="tracking-no"><%= c.getTrackingNumber() %></span></td>

              <td>
                <div style="font-weight:500;"><%= c.getReceiverName() %></div>
              </td>

              <td style="color:var(--muted);">
                <i class="fa-solid fa-phone" style="font-size:10px;margin-right:5px;"></i>
                <%= c.getReceiverPhone() %>
              </td>

              <td>
                <span class="badge-custom <%= badgeClass %>">
                  <span class="dot"></span>
                  <%= status %>
                </span>
              </td>

              <td class="amount-cell">
                <i class="fa-solid fa-indian-rupee-sign"></i> <%= String.format("%.2f", (double) c.getAmount()) %>
              </td>

              <td>
                <a href="trackCourier?tracking=<%= c.getTrackingNumber() %>" class="btn-table btn-track">
                  <i class="fa-solid fa-location-dot"></i> Track
                </a>
                
              </td>
            </tr>
          <%
              }
          } else {
          %>
            <tr>
              <td colspan="7">
                <div class="empty-state">
                  <div><i class="fa-solid fa-box-open"></i></div>
                  <p>No couriers found. <a href="bookCourier.jsp" style="color:var(--accent);font-weight:600;">Book your first courier →</a></p>
                </div>
              </td>
            </tr>
          <%
          }
          %>

          </tbody>
        </table>
      </div>

    </div>
    <!-- end table card -->

  </div>
  <!-- end page body -->

</div>
<!-- end main content -->

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
  function toggleSidebar() {
    document.getElementById('sidebar').classList.toggle('open');
  }

  function filterTable() {
    const q = document.getElementById('searchInput').value.toLowerCase();
    const rows = document.querySelectorAll('#courierTable tbody tr');
    rows.forEach(r => {
      r.style.display = r.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
  }
</script>

</body>
</html>
