<%@ page import="java.util.*, com.courier.model.*" %>

<%
String role = (String) session.getAttribute("role");
if(role == null || !role.equals("admin")){
    response.sendRedirect("login.jsp");
}

List<User> users = (List<User>) request.getAttribute("users");
List<Courier> couriers = (List<Courier>) request.getAttribute("couriers");
List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
List<Feedback> feedbacks = (List<Feedback>) request.getAttribute("feedbacks");

int totalUsers = users != null ? users.size() : 0;
int totalCouriers = couriers != null ? couriers.size() : 0;
int totalComplaints = complaints != null ? complaints.size() : 0;
int totalFeedbacks = feedbacks != null ? feedbacks.size() : 0;

int delivered = 0, inTransit = 0, pending = 0;
if(couriers != null){
    for(Courier c : couriers){
        if("Delivered".equals(c.getStatus())) delivered++;
        else if("In Transit".equals(c.getStatus())) inTransit++;
        else pending++;
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SwiftCourier — Admin Panel</title>

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=Space+Grotesk:wght@400;500;600;700&display=swap" rel="stylesheet">

<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

<style>
/* ── RESET & BASE ── */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

:root {
    --primary:       #0f172a;
    --primary-light: #1e293b;
    --accent:        #3b82f6;
    --accent-2:      #06b6d4;
    --success:       #10b981;
    --warning:       #f59e0b;
    --danger:        #ef4444;
    --sidebar-w:     260px;
    --topbar-h:      64px;
    --bg:            #f0f4ff;
    --card-bg:       #ffffff;
    --text:          #1e293b;
    --text-muted:    #64748b;
    --border:        #e2e8f0;
    --radius:        14px;
    --shadow:        0 4px 24px rgba(15,23,42,0.08);
    --shadow-md:     0 8px 32px rgba(15,23,42,0.12);
}

body {
    font-family: 'Plus Jakarta Sans', sans-serif;
    background: var(--bg);
    color: var(--text);
    min-height: 100vh;
}

/* ── SIDEBAR ── */
.sidebar {
    position: fixed;
    top: 0; left: 0;
    width: var(--sidebar-w);
    height: 100vh;
    background: var(--primary);
    display: flex;
    flex-direction: column;
    z-index: 1000;
    transition: transform .3s ease;
    overflow: hidden;
}

.sidebar::before {
    content: '';
    position: absolute;
    top: -80px; right: -80px;
    width: 240px; height: 240px;
    background: radial-gradient(circle, rgba(59,130,246,.18) 0%, transparent 70%);
    pointer-events: none;
}

.sidebar-logo {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 22px 24px;
    border-bottom: 1px solid rgba(255,255,255,.07);
}

.logo-icon {
    width: 40px; height: 40px;
    background: linear-gradient(135deg, var(--accent), var(--accent-2));
    border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.1rem; color: #fff;
    box-shadow: 0 4px 12px rgba(59,130,246,.4);
}

.logo-text {
    font-family: 'Space Grotesk', sans-serif;
    font-size: 1.1rem;
    font-weight: 700;
    color: #fff;
    line-height: 1.1;
}

.logo-sub {
    font-size: .65rem;
    color: rgba(255,255,255,.45);
    font-weight: 400;
    letter-spacing: .06em;
    text-transform: uppercase;
}

.sidebar-menu {
    flex: 1;
    padding: 20px 12px;
    overflow-y: auto;
}

.menu-label {
    font-size: .65rem;
    font-weight: 700;
    letter-spacing: .1em;
    text-transform: uppercase;
    color: rgba(255,255,255,.3);
    padding: 6px 12px 8px;
    margin-top: 8px;
}

.nav-link-item {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 11px 14px;
    border-radius: 10px;
    color: rgba(255,255,255,.6);
    font-size: .875rem;
    font-weight: 500;
    cursor: pointer;
    transition: all .2s;
    text-decoration: none;
    margin-bottom: 2px;
    border: none;
    background: none;
    width: 100%;
    text-align: left;
}

.nav-link-item i {
    width: 18px;
    text-align: center;
    font-size: .9rem;
}

.nav-link-item:hover,
.nav-link-item.active {
    background: rgba(59,130,246,.15);
    color: #fff;
}

.nav-link-item.active {
    background: linear-gradient(90deg, rgba(59,130,246,.25), rgba(59,130,246,.08));
    color: #93c5fd;
    border-left: 3px solid var(--accent);
}

.nav-link-item .badge-pill {
    margin-left: auto;
    background: var(--accent);
    color: #fff;
    font-size: .65rem;
    font-weight: 700;
    padding: 2px 7px;
    border-radius: 20px;
}

.sidebar-footer {
    padding: 16px;
    border-top: 1px solid rgba(255,255,255,.07);
}

.admin-chip {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 10px 12px;
    background: rgba(255,255,255,.06);
    border-radius: 10px;
}

.admin-avatar {
    width: 34px; height: 34px;
    background: linear-gradient(135deg, var(--accent), var(--accent-2));
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-size: .8rem; color: #fff; font-weight: 700;
    flex-shrink: 0;
}

.admin-info { flex: 1; min-width: 0; }
.admin-name { font-size: .8rem; font-weight: 600; color: #fff; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.admin-role { font-size: .65rem; color: rgba(255,255,255,.4); }

.logout-btn {
    width: 28px; height: 28px;
    background: rgba(239,68,68,.15);
    border: none;
    border-radius: 7px;
    color: #fca5a5;
    display: flex; align-items: center; justify-content: center;
    cursor: pointer;
    transition: all .2s;
    flex-shrink: 0;
    text-decoration: none;
    font-size: .8rem;
}
.logout-btn:hover { background: var(--danger); color: #fff; }

/* ── MAIN LAYOUT ── */
.main-wrap {
    margin-left: var(--sidebar-w);
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

/* ── TOPBAR ── */
.topbar {
    height: var(--topbar-h);
    background: var(--card-bg);
    border-bottom: 1px solid var(--border);
    display: flex;
    align-items: center;
    padding: 0 28px;
    gap: 16px;
    position: sticky;
    top: 0;
    z-index: 900;
}

.topbar-title {
    font-family: 'Space Grotesk', sans-serif;
    font-size: 1rem;
    font-weight: 700;
    color: var(--text);
}

.topbar-breadcrumb {
    font-size: .75rem;
    color: var(--text-muted);
}

.topbar-right {
    margin-left: auto;
    display: flex;
    align-items: center;
    gap: 12px;
}

.topbar-icon-btn {
    width: 36px; height: 36px;
    background: var(--bg);
    border: 1px solid var(--border);
    border-radius: 9px;
    display: flex; align-items: center; justify-content: center;
    color: var(--text-muted);
    font-size: .85rem;
    cursor: pointer;
    transition: all .2s;
    position: relative;
}

.topbar-icon-btn:hover { background: var(--accent); color: #fff; border-color: var(--accent); }

.notif-dot {
    position: absolute;
    top: 6px; right: 6px;
    width: 7px; height: 7px;
    background: var(--danger);
    border-radius: 50%;
    border: 2px solid var(--card-bg);
}

.search-bar {
    display: flex;
    align-items: center;
    gap: 8px;
    background: var(--bg);
    border: 1px solid var(--border);
    border-radius: 9px;
    padding: 6px 14px;
    font-size: .83rem;
    color: var(--text-muted);
    width: 200px;
}

/* ── PAGE CONTENT ── */
.page-content {
    padding: 28px;
    flex: 1;
}

.section-panel { display: none; }
.section-panel.active { display: block; }

/* ── PAGE HEADER ── */
.page-header {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    margin-bottom: 24px;
    flex-wrap: wrap;
    gap: 12px;
}

.page-title {
    font-family: 'Space Grotesk', sans-serif;
    font-size: 1.5rem;
    font-weight: 700;
    color: var(--text);
    line-height: 1.2;
}

.page-subtitle {
    font-size: .8rem;
    color: var(--text-muted);
    margin-top: 3px;
}

/* ── KPI CARDS ── */
.kpi-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 18px;
    margin-bottom: 26px;
}

.kpi-card {
    background: var(--card-bg);
    border-radius: var(--radius);
    padding: 20px 22px;
    box-shadow: var(--shadow);
    border: 1px solid var(--border);
    position: relative;
    overflow: hidden;
    transition: transform .2s, box-shadow .2s;
}

.kpi-card:hover { transform: translateY(-3px); box-shadow: var(--shadow-md); }

.kpi-card::after {
    content: '';
    position: absolute;
    top: 0; right: 0;
    width: 80px; height: 80px;
    border-radius: 0 var(--radius) 0 100%;
    opacity: .07;
}

.kpi-card.blue::after   { background: var(--accent); }
.kpi-card.cyan::after   { background: var(--accent-2); }
.kpi-card.green::after  { background: var(--success); }
.kpi-card.amber::after  { background: var(--warning); }
.kpi-card.red::after    { background: var(--danger); }

.kpi-icon {
    width: 44px; height: 44px;
    border-radius: 11px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.1rem;
    margin-bottom: 14px;
}

.kpi-card.blue  .kpi-icon { background: rgba(59,130,246,.12); color: var(--accent); }
.kpi-card.cyan  .kpi-icon { background: rgba(6,182,212,.12);  color: var(--accent-2); }
.kpi-card.green .kpi-icon { background: rgba(16,185,129,.12); color: var(--success); }
.kpi-card.amber .kpi-icon { background: rgba(245,158,11,.12); color: var(--warning); }
.kpi-card.red   .kpi-icon { background: rgba(239,68,68,.12);  color: var(--danger); }

.kpi-value {
    font-family: 'Space Grotesk', sans-serif;
    font-size: 2rem;
    font-weight: 700;
    line-height: 1;
    margin-bottom: 4px;
}

.kpi-label {
    font-size: .78rem;
    font-weight: 500;
    color: var(--text-muted);
}

.kpi-trend {
    font-size: .72rem;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 3px;
    margin-top: 8px;
    padding: 2px 7px;
    border-radius: 20px;
}

.trend-up   { background: rgba(16,185,129,.1); color: var(--success); }
.trend-down { background: rgba(239,68,68,.1); color: var(--danger); }
.trend-flat { background: rgba(100,116,139,.1); color: var(--text-muted); }

/* ── CHART ROW ── */
.chart-row {
    display: grid;
    grid-template-columns: 1.6fr 1fr;
    gap: 18px;
    margin-bottom: 26px;
}

.chart-card {
    background: var(--card-bg);
    border-radius: var(--radius);
    box-shadow: var(--shadow);
    border: 1px solid var(--border);
    padding: 22px;
}

.chart-card-title {
    font-family: 'Space Grotesk', sans-serif;
    font-weight: 600;
    font-size: .93rem;
    color: var(--text);
    margin-bottom: 4px;
}

.chart-card-sub {
    font-size: .74rem;
    color: var(--text-muted);
    margin-bottom: 18px;
}

/* ── STATUS PILLS ── */
.status-pill {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    padding: 4px 11px;
    border-radius: 20px;
    font-size: .73rem;
    font-weight: 600;
}

.status-delivered { background: rgba(16,185,129,.1); color: var(--success); }
.status-transit   { background: rgba(245,158,11,.12); color: var(--warning); }
.status-pending   { background: rgba(100,116,139,.1); color: var(--text-muted); }
.status-open      { background: rgba(239,68,68,.1);   color: var(--danger); }
.status-resolved  { background: rgba(16,185,129,.1);  color: var(--success); }

.status-pill::before {
    content: '';
    width: 6px; height: 6px;
    border-radius: 50%;
    background: currentColor;
}

/* ── DATA CARD ── */
.data-card {
    background: var(--card-bg);
    border-radius: var(--radius);
    box-shadow: var(--shadow);
    border: 1px solid var(--border);
    overflow: hidden;
    margin-bottom: 26px;
}

.data-card-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 18px 22px 14px;
    border-bottom: 1px solid var(--border);
    flex-wrap: wrap;
    gap: 10px;
}

.data-card-title {
    display: flex;
    align-items: center;
    gap: 10px;
    font-family: 'Space Grotesk', sans-serif;
    font-weight: 600;
    font-size: .93rem;
    color: var(--text);
}

.data-card-icon {
    width: 32px; height: 32px;
    border-radius: 8px;
    display: flex; align-items: center; justify-content: center;
    font-size: .8rem;
}

.icon-blue  { background: rgba(59,130,246,.1); color: var(--accent); }
.icon-cyan  { background: rgba(6,182,212,.1);  color: var(--accent-2); }
.icon-green { background: rgba(16,185,129,.1); color: var(--success); }
.icon-amber { background: rgba(245,158,11,.1); color: var(--warning); }
.icon-red   { background: rgba(239,68,68,.1);  color: var(--danger); }

.data-card-actions {
    display: flex;
    gap: 8px;
    align-items: center;
}

.dc-search {
    background: var(--bg);
    border: 1px solid var(--border);
    border-radius: 8px;
    padding: 6px 12px;
    font-size: .78rem;
    color: var(--text);
    font-family: 'Plus Jakarta Sans', sans-serif;
    outline: none;
}

.dc-search:focus { border-color: var(--accent); }

.btn-primary-sm {
    background: var(--accent);
    color: #fff;
    border: none;
    border-radius: 8px;
    padding: 6px 14px;
    font-size: .78rem;
    font-weight: 600;
    font-family: 'Plus Jakarta Sans', sans-serif;
    cursor: pointer;
    transition: all .2s;
    display: inline-flex;
    align-items: center;
    gap: 5px;
}

.btn-primary-sm:hover { background: #2563eb; }

.btn-success-sm {
    background: var(--success);
    color: #fff;
    border: none;
    border-radius: 7px;
    padding: 5px 12px;
    font-size: .73rem;
    font-weight: 600;
    font-family: 'Plus Jakarta Sans', sans-serif;
    cursor: pointer;
    transition: all .2s;
    display: inline-flex;
    align-items: center;
    gap: 4px;
}

.btn-success-sm:hover { background: #059669; }

.btn-danger-sm {
    background: rgba(239,68,68,.1);
    color: var(--danger);
    border: none;
    border-radius: 7px;
    padding: 5px 10px;
    font-size: .73rem;
    font-weight: 600;
    font-family: 'Plus Jakarta Sans', sans-serif;
    cursor: pointer;
    transition: all .2s;
}

.btn-danger-sm:hover { background: var(--danger); color: #fff; }

/* ── TABLE ── */
.admin-table {
    width: 100%;
    border-collapse: collapse;
}

.admin-table thead tr {
    background: #f8fafc;
    border-bottom: 2px solid var(--border);
}

.admin-table th {
    padding: 11px 16px;
    font-size: .73rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: .05em;
    color: var(--text-muted);
    text-align: left;
    white-space: nowrap;
}

.admin-table td {
    padding: 13px 16px;
    font-size: .83rem;
    color: var(--text);
    border-bottom: 1px solid var(--border);
    vertical-align: middle;
}

.admin-table tbody tr:last-child td { border-bottom: none; }

.admin-table tbody tr {
    transition: background .15s;
}

.admin-table tbody tr:hover { background: #f8fafc; }

.user-cell {
    display: flex;
    align-items: center;
    gap: 10px;
}

.user-avatar {
    width: 32px; height: 32px;
    border-radius: 50%;
    background: linear-gradient(135deg, var(--accent), var(--accent-2));
    display: flex; align-items: center; justify-content: center;
    font-size: .75rem;
    font-weight: 700;
    color: #fff;
    flex-shrink: 0;
}

.user-name { font-weight: 600; font-size: .85rem; }
.user-email { font-size: .74rem; color: var(--text-muted); }

.tracking-code {
    font-family: 'Space Grotesk', monospace;
    font-size: .8rem;
    background: var(--bg);
    border: 1px solid var(--border);
    border-radius: 6px;
    padding: 3px 8px;
    color: var(--accent);
    font-weight: 600;
}

.star-rating { color: var(--warning); }

/* ── RATING STARS ── */
.rating-stars { display: inline-flex; gap: 2px; }
.rating-stars i { font-size: .8rem; }

/* ── PROGRESS BAR ── */
.mini-progress {
    width: 80px;
    height: 6px;
    background: var(--border);
    border-radius: 3px;
    overflow: hidden;
}

.mini-progress-bar {
    height: 100%;
    border-radius: 3px;
    background: linear-gradient(90deg, var(--accent), var(--accent-2));
}

/* ── EMPTY STATE ── */
.empty-state {
    text-align: center;
    padding: 48px 24px;
    color: var(--text-muted);
}

.empty-state i { font-size: 2.5rem; opacity: .3; margin-bottom: 12px; }
.empty-state p { font-size: .85rem; }

/* ── MOBILE TOGGLE ── */
.sidebar-toggle {
    display: none;
    background: none;
    border: none;
    font-size: 1.2rem;
    color: var(--text-muted);
    cursor: pointer;
}

/* ── RESPONSIVE ── */
@media (max-width: 1200px) {
    .kpi-grid { grid-template-columns: repeat(2, 1fr); }
    .chart-row { grid-template-columns: 1fr; }
}

@media (max-width: 768px) {
    .sidebar { transform: translateX(-100%); }
    .sidebar.open { transform: translateX(0); }
    .main-wrap { margin-left: 0; }
    .sidebar-toggle { display: block; }
    .kpi-grid { grid-template-columns: 1fr 1fr; }
    .page-content { padding: 18px; }
}

@media (max-width: 480px) {
    .kpi-grid { grid-template-columns: 1fr; }
}

/* ── SCROLLBAR ── */
::-webkit-scrollbar { width: 5px; height: 5px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb { background: var(--border); border-radius: 3px; }
</style>
</head>

<body>

<!-- ═══════════════════════════════════════════════
     SIDEBAR
══════════════════════════════════════════════════ -->
<aside class="sidebar" id="sidebar">

    <!-- Logo -->
    <div class="sidebar-logo">
        <div class="logo-icon"><i class="fa-solid fa-truck-fast"></i></div>
        <div>
            <div class="logo-text">CMS</div>
            <div class="logo-sub">Admin Panel</div>
        </div>
    </div>

    <!-- Navigation -->
    <nav class="sidebar-menu">
        <div class="menu-label">Main</div>

        <button class="nav-link-item active" onclick="showPanel('dashboard', this)">
            <i class="fa-solid fa-gauge-high"></i>
            Dashboard
        </button>

        <div class="menu-label">Management</div>

        <button class="nav-link-item" onclick="showPanel('users', this)">
            <i class="fa-solid fa-users"></i>
            Users
            <span class="badge-pill"><%= totalUsers %></span>
        </button>

        <button class="nav-link-item" onclick="showPanel('couriers', this)">
            <i class="fa-solid fa-box"></i>
            Couriers
            <span class="badge-pill"><%= totalCouriers %></span>
        </button>
         
        <button class="nav-link-item" onclick="showPanel('complaints', this)">
            <i class="fa-solid fa-triangle-exclamation"></i>
            Complaints
            <span class="badge-pill" style="background:var(--danger)"><%= totalComplaints %></span>
        </button>

        <button class="nav-link-item" onclick="showPanel('feedback', this)">
            <i class="fa-solid fa-star"></i>
            Feedback
        </button>

        <div class="menu-label">Analytics</div>

        <button class="nav-link-item" onclick="showPanel('reports', this)">
            <i class="fa-solid fa-chart-bar"></i>
            Reports
        </button>

        <div class="menu-label">System</div>

        <button class="nav-link-item" onclick="showPanel('settings', this)">
            <i class="fa-solid fa-gear"></i>
            Settings
        </button>
    </nav>

    <!-- Admin footer -->
    <div class="sidebar-footer">
        <div class="admin-chip">
            <div class="admin-avatar">AD</div>
            <div class="admin-info">
                <div class="admin-name">Administrator</div>
                <div class="admin-role">Super Admin</div>
            </div>
            <a href="<%=request.getContextPath()%>/logout" class="logout-btn" title="Logout">
                <i class="fa-solid fa-right-from-bracket"></i>
            </a>
        </div>
    </div>
</aside>

<!-- ═══════════════════════════════════════════════
     MAIN WRAPPER
══════════════════════════════════════════════════ -->
<div class="main-wrap">

    <!-- TOP BAR -->
    <header class="topbar">
        <button class="sidebar-toggle" onclick="document.getElementById('sidebar').classList.toggle('open')">
            <i class="fa-solid fa-bars"></i>
        </button>

        <div>
            <div class="topbar-title" id="topbar-title">Dashboard</div>
            <div class="topbar-breadcrumb">CMS / <span id="topbar-crumb">Overview</span></div>
        </div>

        <div class="topbar-right">
            <div class="search-bar">
                <i class="fa-solid fa-magnifying-glass" style="font-size:.8rem"></i>
                Search...
            </div>
            <div class="topbar-icon-btn">
                <i class="fa-solid fa-bell"></i>
                <div class="notif-dot"></div>
            </div>
            <div class="topbar-icon-btn">
                <i class="fa-solid fa-circle-question"></i>
            </div>
        </div>
    </header>

    <!-- PAGE CONTENT -->
    <main class="page-content">

<!-- ══════════════════════════════════
     DASHBOARD PANEL
════════════════════════════════════ -->
<div class="section-panel active" id="panel-dashboard">

    <div class="page-header container">
        <div class="row">
            <div class="page-title col-lg-12"><h4>Good Morning, Admin <p>Hello! &#128075;</p></h4></div>
            <div class="page-subtitle col-lg-12"><p>Here's what's happening with your courier network today.</p>
            </div>
        </div>
    </div>

    <!-- KPI CARDS -->
    <div class="kpi-grid">
        <div class="kpi-card blue">
            <div class="kpi-icon"><i class="fa-solid fa-users"></i></div>
            <div class="kpi-value"><%= totalUsers %></div>
            <div class="kpi-label">Total Users</div>
            <div class="kpi-trend trend-up"><i class="fa-solid fa-arrow-trend-up"></i> +12% this month</div>
        </div>

        <div class="kpi-card cyan">
            <div class="kpi-icon"><i class="fa-solid fa-box"></i></div>
            <div class="kpi-value"><%= totalCouriers %></div>
            <div class="kpi-label">Total Couriers</div>
            <div class="kpi-trend trend-up"><i class="fa-solid fa-arrow-trend-up"></i> +8% this month</div>
        </div>

        <div class="kpi-card green">
            <div class="kpi-icon"><i class="fa-solid fa-circle-check"></i></div>
            <div class="kpi-value"><%= delivered %></div>
            <div class="kpi-label">Delivered</div>
            <div class="kpi-trend trend-up"><i class="fa-solid fa-arrow-trend-up"></i> On track</div>
        </div>

        <div class="kpi-card amber">
            <div class="kpi-icon"><i class="fa-solid fa-truck"></i></div>
            <div class="kpi-value"><%= inTransit %></div>
            <div class="kpi-label">In Transit</div>
            <div class="kpi-trend trend-flat"><i class="fa-solid fa-minus"></i> Active shipments</div>
        </div>
    </div>

    <!-- Second KPI row -->
    <div class="kpi-grid" style="grid-template-columns: repeat(3,1fr); margin-top: -8px;">
        <div class="kpi-card red">
            <div class="kpi-icon"><i class="fa-solid fa-triangle-exclamation"></i></div>
            <div class="kpi-value"><%= totalComplaints %></div>
            <div class="kpi-label">Open Complaints</div>
            <div class="kpi-trend trend-down"><i class="fa-solid fa-arrow-trend-down"></i> Needs attention</div>
        </div>

        <div class="kpi-card amber">
            <div class="kpi-icon"><i class="fa-solid fa-clock"></i></div>
            <div class="kpi-value"><%= pending %></div>
            <div class="kpi-label">Pending Shipments</div>
            <div class="kpi-trend trend-flat"><i class="fa-solid fa-minus"></i> Awaiting pickup</div>
        </div>

        <div class="kpi-card blue">
            <div class="kpi-icon"><i class="fa-solid fa-star"></i></div>
            <div class="kpi-value"><%= totalFeedbacks %></div>
            <div class="kpi-label">Feedback Received</div>
            <div class="kpi-trend trend-up"><i class="fa-solid fa-arrow-trend-up"></i> Good engagement</div>
        </div>
    </div>

    <!-- Charts row -->
    <div class="chart-row">
        <div class="chart-card">
            <div class="chart-card-title">Courier Activity</div>
            <div class="chart-card-sub">Monthly shipment volume — last 6 months</div>
            <canvas id="lineChart" height="120"></canvas>
        </div>
        <div class="chart-card">
            <div class="chart-card-title">Shipment Status</div>
            <div class="chart-card-sub">Current distribution by status</div>
            <canvas id="doughnutChart" height="140"></canvas>
        </div>
    </div>

    <!-- Recent couriers mini-table -->
    <div class="data-card">
        <div class="data-card-header">
            <div class="data-card-title">
                <div class="data-card-icon icon-cyan"><i class="fa-solid fa-box"></i></div>
                Recent Shipments
            </div>
             
        </div>
        <table class="admin-table">
            <thead>
                <tr>
                    <th>Tracking #</th>
                    <th>Sender</th>
                    <th>Receiver</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
<%
if(couriers != null){
    int dashLimit = Math.min(5, couriers.size());
    for(int i = 0; i < dashLimit; i++){
        Courier c = couriers.get(i);
        String statusClass = "Delivered".equals(c.getStatus()) ? "status-delivered" :
                             "In Transit".equals(c.getStatus()) ? "status-transit" : "status-pending";
%>
                <tr>
                    <td><span class="tracking-code"><%= c.getTrackingNumber() %></span></td>
                    <td><%= c.getSenderEmail() %></td>
                    <td><%= c.getReceiverName() %></td>
                    <td><span class="status-pill <%= statusClass %>"><%= c.getStatus() %></span></td>
                </tr>
<%
    }
} else {
%>
                <tr><td colspan="4">
                    <div class="empty-state">
                        <i class="fa-solid fa-box-open"></i>
                        <p>No shipment records found</p>
                    </div>
                </td></tr>
<% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- ══════════════════════════════════
     USERS PANEL
════════════════════════════════════ -->
<div class="section-panel" id="panel-users">

    <div class="page-header">
        <div>
            <div class="page-title">User Management</div>
            <div class="page-subtitle">All registered users — <%= totalUsers %> total</div>
        </div>
         
    </div>

    <div class="data-card">
        <div class="data-card-header">
            <div class="data-card-title">
                <div class="data-card-icon icon-blue"><i class="fa-solid fa-users"></i></div>
                All Users
            </div>
            <div class="data-card-actions">
                <input class="dc-search" type="text" placeholder="Search users..." oninput="filterTable(this,'users-tbody')">
                 
            </div>
        </div>
        <table class="admin-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>User</th>
                    <th>Phone</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="users-tbody">
<%
if(users != null && !users.isEmpty()){
    int idx = 1;
    for(User u : users){
        String initials = u.getFullName() != null && u.getFullName().length() > 0
            ? String.valueOf(u.getFullName().charAt(0)).toUpperCase()
            : "U";
%>
                <tr>
                    <td style="color:var(--text-muted);font-size:.8rem"><%= idx++ %></td>
                    <td>
                        <div class="user-cell">
                            <div class="user-avatar"><%= initials %></div>
                            <div>
                                <div class="user-name"><%= u.getFullName() %></div>
                                <div class="user-email"><%= u.getEmail() %></div>
                            </div>
                        </div>
                    </td>
                    <td><%= u.getPhone() %></td>
                    <td><span class="status-pill status-delivered">Active</span></td>
                    <td>
                        <div style="display:flex;gap:6px">
                        <!-- <button class="btn-primary-sm" style="padding:4px 10px;font-size:.72rem">
                                <i class="fa-solid fa-pen"></i>
                            </button> -->
                            
                            <form action="<%=request.getContextPath()%>/deleteUser" method="post" style="display:inline">
					            <input type="hidden" name="email" value="<%= u.getEmail() %>">
					            
					            <button type="submit" class="btn-danger-sm">
					                <i class="fa-solid fa-trash"></i>
					            </button>
					        </form>
                        </div>
                    </td>
                </tr>
<%
    }
} else {
%>
                <tr><td colspan="5">
                    <div class="empty-state">
                        <i class="fa-solid fa-users"></i>
                        <p>No users found</p>
                    </div>
                </td></tr>
<% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- ══════════════════════════════════
     COURIERS PANEL
════════════════════════════════════ -->
<div class="section-panel" id="panel-couriers">

    <div class="page-header">
        <div>
            <div class="page-title">Courier Management</div>
            <div class="page-subtitle">Track and manage all shipments — <%= totalCouriers %> total</div>
        </div>
         
    </div>

    <!-- Mini KPIs -->
    <div class="kpi-grid" style="grid-template-columns:repeat(3,1fr);margin-bottom:20px;">
        <div class="kpi-card green" style="padding:14px 18px;">
            <div style="display:flex;align-items:center;gap:10px;">
                <div class="kpi-icon" style="margin-bottom:0;width:36px;height:36px;border-radius:9px;font-size:.9rem;">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
                <div>
                    <div class="kpi-value" style="font-size:1.4rem"><%= delivered %></div>
                    <div class="kpi-label">Delivered</div>
                </div>
            </div>
        </div>
        <div class="kpi-card amber" style="padding:14px 18px;">
            <div style="display:flex;align-items:center;gap:10px;">
                <div class="kpi-icon" style="margin-bottom:0;width:36px;height:36px;border-radius:9px;font-size:.9rem;">
                    <i class="fa-solid fa-truck"></i>
                </div>
                <div>
                    <div class="kpi-value" style="font-size:1.4rem"><%= inTransit %></div>
                    <div class="kpi-label">In Transit</div>
                </div>
            </div>
        </div>
        <div class="kpi-card blue" style="padding:14px 18px;">
            <div style="display:flex;align-items:center;gap:10px;">
                <div class="kpi-icon" style="margin-bottom:0;width:36px;height:36px;border-radius:9px;font-size:.9rem;">
                    <i class="fa-solid fa-clock"></i>
                </div>
                <div>
                    <div class="kpi-value" style="font-size:1.4rem"><%= pending %></div>
                    <div class="kpi-label">Pending</div>
                </div>
            </div>
        </div>
    </div>

    <div class="data-card">
        <div class="data-card-header">
            <div class="data-card-title">
                <div class="data-card-icon icon-cyan"><i class="fa-solid fa-box"></i></div>
                All Shipments
            </div>
            <div class="data-card-actions">
                <input class="dc-search" type="text" placeholder="Search tracking..." oninput="filterTable(this,'couriers-tbody')">
                 
            </div>
        </div>
        <table class="admin-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Tracking #</th>
                    <th>Sender</th>
                    <th>Receiver</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="couriers-tbody">
<%
if(couriers != null && !couriers.isEmpty()){
    int idx = 1;
    for(Courier c : couriers){
        String statusClass = "Delivered".equals(c.getStatus()) ? "status-delivered" :
                             "In Transit".equals(c.getStatus()) ? "status-transit" : "status-pending";
%>
                <tr>
                    <td style="color:var(--text-muted);font-size:.8rem"><%= idx++ %></td>
                    <td><span class="tracking-code"><%= c.getTrackingNumber() %></span></td>
                    <td><%= c.getSenderEmail() %></td>
                    <td><%= c.getReceiverName() %></td>
                    <td><span class="status-pill <%= statusClass %>"><%= c.getStatus() %></span></td>
                    <td>
                        <div style="display:flex;gap:6px">
	                        <a href="updateStatus.jsp?tracking=<%= c.getTrackingNumber() %>" 
					           class="btn-primary-sm">
					           <i class="fa-solid fa-pen"></i>
					        </a>
                            
                            <form action="<%=request.getContextPath()%>/deleteCourier" method="post" style="display:inline">
							    <input type="hidden" name="tracking" value="<%= c.getTrackingNumber() %>">
							    <button type="submit" class="btn-danger-sm">
							        <i class="fa-solid fa-trash"></i>
							    </button>
							</form>
                        </div>
                    </td>
                </tr>
<%
    }
} else {
%>
                <tr><td colspan="6">
                    <div class="empty-state">
                        <i class="fa-solid fa-box-open"></i>
                        <p>No shipments found</p>
                    </div>
                </td></tr>
<% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- ══════════════════════════════════
     COMPLAINTS PANEL
════════════════════════════════════ -->
<div class="section-panel" id="panel-complaints">

    <div class="page-header">
        <div>
            <div class="page-title">Complaint Management</div>
            <div class="page-subtitle">Review and resolve user complaints — <%= totalComplaints %> open</div>
        </div>
    </div>

    <div class="data-card">
        <div class="data-card-header">
            <div class="data-card-title">
                <div class="data-card-icon icon-red"><i class="fa-solid fa-triangle-exclamation"></i></div>
                All Complaints
            </div>
            <div class="data-card-actions">
                <input class="dc-search" type="text" placeholder="Search complaints..." oninput="filterTable(this,'complaints-tbody')">
            </div>
        </div>
        <table class="admin-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>User Email</th>
                    <th>Subject</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="complaints-tbody">
<%
if(complaints != null && !complaints.isEmpty()){
    int idx = 1;
    for(Complaint c : complaints){
        String statusClass = "Resolved".equalsIgnoreCase(c.getStatus()) ? "status-resolved" : "status-open";
%>
                <tr>
                    <td style="color:var(--text-muted);font-size:.8rem"><%= idx++ %></td>
                    <td><%= c.getUserEmail() %></td>
                    <td><%= c.getSubject() %></td>
                    <td><span class="status-pill <%= statusClass %>"><%= c.getStatus() %></span></td>
                    <td>
                        <form action="<%=request.getContextPath()%>/updateComplaintStatus" method="post" style="display:inline">
                            <input type="hidden" name="email" value="<%= c.getUserEmail() %>">
                            <button type="submit" class="btn btn-success btn-sm">
                                <i class="fa-solid fa-check"></i> Resolve
                            </button>
                        </form>
                    </td>
                </tr>
<%
    }
} else {
%>
                <tr><td colspan="5">
                    <div class="empty-state">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                        <p>No complaints found</p>
                    </div>
                </td></tr>
<% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- ══════════════════════════════════
     FEEDBACK PANEL
════════════════════════════════════ -->
<div class="section-panel" id="panel-feedback">

    <div class="page-header">
        <div>
            <div class="page-title">User Feedback</div>
            <div class="page-subtitle">Customer ratings and messages — <%= totalFeedbacks %> total</div>
        </div>
    </div>

    <div class="data-card">
        <div class="data-card-header">
            <div class="data-card-title">
                <div class="data-card-icon icon-amber"><i class="fa-solid fa-star"></i></div>
                All Feedback
            </div>
            <div class="data-card-actions">
                <input class="dc-search" type="text" placeholder="Search feedback..." oninput="filterTable(this,'feedback-tbody')">
            </div>
        </div>
        <table class="admin-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>User Email</th>
                    <th>Message</th>
                    <th>Rating</th>
                </tr>
            </thead>
            <tbody id="feedback-tbody">
<%
if(feedbacks != null && !feedbacks.isEmpty()){
    int idx = 1;
    for(Feedback f : feedbacks){
%>
                <tr>
                    <td style="color:var(--text-muted);font-size:.8rem"><%= idx++ %></td>
                    <td><%= f.getUserEmail() %></td>
                    <td><%= f.getMessage() %></td>
                    <td>
                        <div class="rating-stars">
<%
                            int rating = f.getRating();
                            for(int s = 1; s <= 5; s++){
                                if(s <= rating) { %><i class="fa-solid fa-star" style="color:var(--warning)"></i><% }
                                else { %><i class="fa-regular fa-star" style="color:var(--border)"></i><% }
                            }
%>
                        </div>
                        <div style="font-size:.72rem;color:var(--text-muted);margin-top:2px"><%= f.getRating() %> / 5</div>
                    </td>
                </tr>
<%
    }
} else {
%>
                <tr><td colspan="4">
                    <div class="empty-state">
                        <i class="fa-solid fa-star"></i>
                        <p>No feedback found</p>
                    </div>
                </td></tr>
<% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- ══════════════════════════════════
     REPORTS PANEL
════════════════════════════════════ -->
<div class="section-panel" id="panel-reports">

    <div class="page-header">
        <div>
            <div class="page-title">Reports & Analytics</div>
            <div class="page-subtitle">Operational overview and performance metrics</div>
        </div>
         
    </div>

    <!-- Summary KPIs for report -->
    <div class="kpi-grid" style="margin-bottom:22px;">
        <div class="kpi-card blue">
            <div class="kpi-icon"><i class="fa-solid fa-users"></i></div>
            <div class="kpi-value"><%= totalUsers %></div>
            <div class="kpi-label">Registered Users</div>
        </div>
        <div class="kpi-card cyan">
            <div class="kpi-icon"><i class="fa-solid fa-box"></i></div>
            <div class="kpi-value"><%= totalCouriers %></div>
            <div class="kpi-label">Total Shipments</div>
        </div>
        <div class="kpi-card green">
            <div class="kpi-icon"><i class="fa-solid fa-circle-check"></i></div>
            <div class="kpi-value"><%= delivered %></div>
            <div class="kpi-label">Successfully Delivered</div>
        </div>
        <div class="kpi-card red">
            <div class="kpi-icon"><i class="fa-solid fa-triangle-exclamation"></i></div>
            <div class="kpi-value"><%= totalComplaints %></div>
            <div class="kpi-label">Total Complaints</div>
        </div>
    </div>

    <div class="chart-row" style="grid-template-columns:1fr 1fr;">
        <div class="chart-card">
            <div class="chart-card-title">Delivery Performance</div>
            <div class="chart-card-sub">Breakdown of shipment outcomes</div>
            <canvas id="barChart" height="160"></canvas>
        </div>
        <div class="chart-card">
            <div class="chart-card-title">User Growth</div>
            <div class="chart-card-sub">New registrations per month</div>
            <canvas id="areaChart" height="160"></canvas>
        </div>
    </div>

    <!-- Delivery rate indicator -->
    <div class="data-card">
        <div class="data-card-header">
            <div class="data-card-title">
                <div class="data-card-icon icon-green"><i class="fa-solid fa-chart-bar"></i></div>
                Delivery Rate Summary
            </div>
        </div>
        <div style="padding:22px;">
            <% int deliveryPct = totalCouriers > 0 ? (int)((delivered * 100.0) / totalCouriers) : 0; %>
            <% int transitPct  = totalCouriers > 0 ? (int)((inTransit * 100.0) / totalCouriers) : 0; %>
            <% int pendingPct  = totalCouriers > 0 ? (int)((pending * 100.0) / totalCouriers) : 0; %>

            <div style="margin-bottom:18px">
                <div style="display:flex;justify-content:space-between;margin-bottom:6px">
                    <span style="font-size:.83rem;font-weight:600">Delivered</span>
                    <span style="font-size:.83rem;color:var(--success);font-weight:700"><%= deliveryPct %>%</span>
                </div>
                <div style="height:10px;background:var(--border);border-radius:5px;overflow:hidden">
                    <div style="height:100%;width:<%= deliveryPct %>%;background:linear-gradient(90deg,var(--success),#34d399);border-radius:5px;transition:width .8s ease"></div>
                </div>
            </div>

            <div style="margin-bottom:18px">
                <div style="display:flex;justify-content:space-between;margin-bottom:6px">
                    <span style="font-size:.83rem;font-weight:600">In Transit</span>
                    <span style="font-size:.83rem;color:var(--warning);font-weight:700"><%= transitPct %>%</span>
                </div>
                <div style="height:10px;background:var(--border);border-radius:5px;overflow:hidden">
                    <div style="height:100%;width:<%= transitPct %>%;background:linear-gradient(90deg,var(--warning),#fcd34d);border-radius:5px;transition:width .8s ease"></div>
                </div>
            </div>

            <div>
                <div style="display:flex;justify-content:space-between;margin-bottom:6px">
                    <span style="font-size:.83rem;font-weight:600">Pending</span>
                    <span style="font-size:.83rem;color:var(--text-muted);font-weight:700"><%= pendingPct %>%</span>
                </div>
                <div style="height:10px;background:var(--border);border-radius:5px;overflow:hidden">
                    <div style="height:100%;width:<%= pendingPct %>%;background:linear-gradient(90deg,var(--text-muted),#94a3b8);border-radius:5px;transition:width .8s ease"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ══════════════════════════════════
     SETTINGS PANEL
════════════════════════════════════ -->
<div class="section-panel" id="panel-settings">

    <div class="page-header">
        <div>
            <div class="page-title">System Settings</div>
            <div class="page-subtitle">Configure system preferences and admin options</div>
        </div>
    </div>

    <div style="display:grid;grid-template-columns:1fr 1fr;gap:18px;">

        <div class="data-card">
            <div class="data-card-header">
                <div class="data-card-title">
                    <div class="data-card-icon icon-blue"><i class="fa-solid fa-user-shield"></i></div>
                    Admin Profile
                </div>
            </div>
            <div style="padding:22px;">
                <div style="display:flex;align-items:center;gap:14px;margin-bottom:20px">
                    <div style="width:60px;height:60px;border-radius:50%;background:linear-gradient(135deg,var(--accent),var(--accent-2));display:flex;align-items:center;justify-content:center;font-size:1.4rem;font-weight:700;color:#fff">A</div>
                    <div>
                        <div style="font-weight:700;font-size:1rem">Administrator</div>
                        <div style="font-size:.78rem;color:var(--text-muted)">admin@cms</div>
                        <span class="status-pill status-delivered" style="margin-top:4px;display:inline-flex">Super Admin</span>
                    </div>
                </div>
                <!--
                <div style="display:flex;flex-direction:column;gap:10px">
                    <button class="btn-primary-sm" style="justify-content:center">
                        <i class="fa-solid fa-pen"></i> Edit Profile
                    </button>
                    <button class="btn-primary-sm" style="justify-content:center;background:var(--primary-light)">
                        <i class="fa-solid fa-key"></i> Change Password
                    </button>
                </div> -->
            </div>
        </div>

          
        <div class="data-card" style="grid-column:1/-1">
            <div class="data-card-header">
                <div class="data-card-title">
                    <div class="data-card-icon icon-red"><i class="fa-solid fa-shield-halved"></i></div>
                    Danger Zone
                </div>
            </div>
            <div style="padding:22px;display:flex;gap:12px;flex-wrap:wrap">
                 
                <a href="<%=request.getContextPath()%>/logout" class="btn-danger-sm" style="padding:8px 16px;font-size:.8rem;text-decoration:none">
                    <i class="fa-solid fa-right-from-bracket"></i> Logout Now
                </a>
            </div>
        </div>
    </div>
</div>

    </main>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
/* ── PANEL NAVIGATION ── */
function showPanel(name, btn) {
    document.querySelectorAll('.section-panel').forEach(p => p.classList.remove('active'));
    document.getElementById('panel-' + name).classList.add('active');
    document.querySelectorAll('.nav-link-item').forEach(b => b.classList.remove('active'));
    if(btn) btn.classList.add('active');
    const titles = {
        dashboard: ['Dashboard', 'Overview'],
        users: ['User Management', 'Users'],
        couriers: ['Courier Management', 'Couriers'],
        complaints: ['Complaints', 'Complaints'],
        feedback: ['Feedback', 'Feedback'],
        reports: ['Reports & Analytics', 'Reports'],
        settings: ['System Settings', 'Settings']
    };
    document.getElementById('topbar-title').textContent = titles[name][0];
    document.getElementById('topbar-crumb').textContent = titles[name][1];
    document.getElementById('sidebar').classList.remove('open');
}

/* ── TABLE SEARCH FILTER ── */
function filterTable(input, tbodyId) {
    const q = input.value.toLowerCase();
    const rows = document.getElementById(tbodyId).querySelectorAll('tr');
    rows.forEach(r => {
        r.style.display = r.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
}

/* ── CHARTS ── */
const delivered  = <%= delivered %>;
const inTransit  = <%= inTransit %>;
const pending    = <%= pending %>;

// Doughnut chart
new Chart(document.getElementById('doughnutChart'), {
    type: 'doughnut',
    data: {
        labels: ['Delivered', 'In Transit', 'Pending'],
        datasets: [{
            data: [delivered || 1, inTransit || 0, pending || 0],
            backgroundColor: ['#10b981', '#f59e0b', '#94a3b8'],
            borderWidth: 0,
            hoverOffset: 6
        }]
    },
    options: {
        cutout: '70%',
        plugins: {
            legend: { position: 'bottom', labels: { padding: 16, font: { size: 11, family: 'Plus Jakarta Sans' } } }
        }
    }
});

// Line chart
new Chart(document.getElementById('lineChart'), {
    type: 'line',
    data: {
        labels: ['Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr'],
        datasets: [{
            label: 'Shipments',
            data: [12, 19, 15, 27, 22, Math.max(1, <%= totalCouriers %>)],
            borderColor: '#3b82f6',
            backgroundColor: 'rgba(59,130,246,.08)',
            fill: true,
            tension: .4,
            pointBackgroundColor: '#3b82f6',
            pointRadius: 4,
            borderWidth: 2
        }]
    },
    options: {
        plugins: { legend: { display: false } },
        scales: {
            y: { grid: { color: '#f1f5f9' }, ticks: { font: { size: 11 } } },
            x: { grid: { display: false }, ticks: { font: { size: 11 } } }
        }
    }
});

// Bar chart (Reports page)
new Chart(document.getElementById('barChart'), {
    type: 'bar',
    data: {
        labels: ['Delivered', 'In Transit', 'Pending'],
        datasets: [{
            label: 'Count',
            data: [delivered, inTransit, pending],
            backgroundColor: ['rgba(16,185,129,.7)', 'rgba(245,158,11,.7)', 'rgba(148,163,184,.7)'],
            borderRadius: 8,
            borderSkipped: false
        }]
    },
    options: {
        plugins: { legend: { display: false } },
        scales: {
            y: { grid: { color: '#f1f5f9' }, ticks: { font: { size: 11 } } },
            x: { grid: { display: false }, ticks: { font: { size: 11 } } }
        }
    }
});

// Area chart
new Chart(document.getElementById('areaChart'), {
    type: 'line',
    data: {
        labels: ['Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr'],
        datasets: [{
            label: 'New Users',
            data: [4, 7, 5, 9, 11, Math.max(1, <%= totalUsers %>)],
            borderColor: '#06b6d4',
            backgroundColor: 'rgba(6,182,212,.1)',
            fill: true,
            tension: .4,
            pointBackgroundColor: '#06b6d4',
            pointRadius: 4,
            borderWidth: 2
        }]
    },
    options: {
        plugins: { legend: { display: false } },
        scales: {
            y: { grid: { color: '#f1f5f9' }, ticks: { font: { size: 11 } } },
            x: { grid: { display: false }, ticks: { font: { size: 11 } } }
        }
    }
});
</script>

</body>
</html>
