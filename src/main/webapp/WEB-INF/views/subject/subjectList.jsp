<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tutorsystem.model.Subject" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Subject Management</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: #f0f2f5; font-family: 'Inter', sans-serif; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar { background: #0f1f3d; padding: 0 2rem; height: 56px; display: flex; align-items: center; justify-content: space-between; }
        .navbar-brand { color: #fff; font-size: 1rem; font-weight: 600; }
        .navbar-right { display: flex; align-items: center; gap: 1rem; }
        .navbar-user { color: #cbd5e1; font-size: .9rem; }
        .btn-logout { color: #fff; border: 1px solid #fff; background: transparent; padding: .35rem .9rem; border-radius: 6px; font-size: .85rem; text-decoration: none; }
        main { max-width: 1100px; margin: 2rem auto; padding: 0 1.5rem; flex: 1; width: 100%; }
        .toast { background: #dcfce7; color: #16a34a; border: 1px solid #a5d6a7; padding: .85rem 1.2rem; border-radius: 10px; margin-bottom: 1.5rem; font-size: .9rem; font-weight: 500; }
        .page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 1.5rem; }
        .page-header h2 { font-size: 1.3rem; font-weight: 700; color: #0f1f3d; }
        .toolbar { display: flex; gap: 1rem; align-items: center; margin-bottom: 1.5rem; flex-wrap: wrap; }
        .search-form { flex: 1; display: flex; gap: .5rem; background: #fff; border: 1px solid #dde1e7; border-radius: 8px; padding: .5rem 1rem; align-items: center; }
        .search-form input { background: none; border: none; outline: none; color: #1e293b; font-size: .9rem; flex: 1; font-family: 'Inter', sans-serif; }
        .search-form button { background: #0f1f3d; border: none; color: #fff; padding: .4rem .9rem; border-radius: 6px; cursor: pointer; font-size: .85rem; font-weight: 500; font-family: 'Inter', sans-serif; }
        .btn-add { background: #0f1f3d; color: #fff; border: none; padding: .55rem 1.2rem; border-radius: 8px; font-weight: 600; font-size: .9rem; text-decoration: none; white-space: nowrap; }
        .btn-add:hover { background: #1a3260; }
        .card { background: #fff; border: 1px solid #e2e8f0; border-radius: 12px; overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        thead { background: #f8fafc; }
        th { padding: .9rem 1.2rem; text-align: left; font-size: .75rem; font-weight: 600; letter-spacing: .8px; text-transform: uppercase; color: #64748b; border-bottom: 1px solid #e2e8f0; }
        td { padding: .9rem 1.2rem; border-bottom: 1px solid #f1f5f9; font-size: .88rem; color: #1e293b; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: #f8fafc; }
        .status { padding: 3px 12px; border-radius: 20px; font-size: .75rem; font-weight: 600; }
        .active { background: #dcfce7; color: #16a34a; }
        .inactive { background: #fee2e2; color: #dc2626; }
        .chip { background: #eff6ff; color: #1d4ed8; padding: 2px 10px; border-radius: 20px; font-size: .78rem; font-weight: 500; }
        .actions { display: flex; gap: .5rem; }
        .btn-edit { background: #0f1f3d; color: #fff; border: none; padding: .35rem .9rem; border-radius: 6px; font-size: .8rem; font-weight: 500; text-decoration: none; }
        .btn-edit:hover { background: #1a3260; }
        .btn-delete { background: #fff; color: #dc2626; border: 1.5px solid #dc2626; padding: .35rem .9rem; border-radius: 6px; font-size: .8rem; font-weight: 500; cursor: pointer; font-family: 'Inter', sans-serif; }
        .btn-delete:hover { background: #dc2626; color: #fff; }
        .empty { text-align: center; padding: 3rem 1rem; color: #94a3b8; }
        .empty .icon { font-size: 2.5rem; margin-bottom: .8rem; }
        .modal-overlay { display: none; position: fixed; inset: 0; background: #00000066; z-index: 100; align-items: center; justify-content: center; }
        .modal-overlay.show { display: flex; }
        .modal { background: #fff; border-radius: 12px; padding: 2rem; width: 380px; text-align: center; }
        .modal h3 { font-size: 1.1rem; color: #0f1f3d; margin-bottom: .5rem; }
        .modal p { color: #64748b; font-size: .9rem; margin-bottom: 1.5rem; }
        .modal-btns { display: flex; gap: 1rem; justify-content: center; }
        .modal-btns .cancel { background: #f1f5f9; color: #64748b; border: none; padding: .6rem 1.4rem; border-radius: 8px; cursor: pointer; font-weight: 600; font-family: 'Inter', sans-serif; }
        .modal-btns .confirm { background: #dc2626; color: #fff; border: none; padding: .6rem 1.4rem; border-radius: 8px; cursor: pointer; font-weight: 600; font-family: 'Inter', sans-serif; }
        footer { background: #0f1117; color: #94a3b8; margin-top: 4rem; }
        .footer-grid { max-width: 1100px; margin: 0 auto; padding: 3rem 1.5rem; display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 2rem; }
        .footer-brand h3 { color: #fff; font-size: 1.1rem; margin-bottom: .8rem; }
        .footer-brand p { font-size: .85rem; line-height: 1.7; }
        .footer-col h4 { color: #fff; font-size: .75rem; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 1rem; }
        .footer-col ul { list-style: none; display: flex; flex-direction: column; gap: .6rem; }
        .footer-col ul a { color: #94a3b8; text-decoration: none; font-size: .9rem; }
        .footer-col ul a:hover { color: #fff; }
        .footer-col p { font-size: .85rem; line-height: 1.7; }
        .footer-col .address-title { font-size: .85rem; font-weight: 600; color: #fff; margin-bottom: .4rem; }
        .footer-col .meet-link { color: #38bdf8; font-size: .85rem; text-decoration: none; display: inline-block; margin-top: .6rem; }
        .footer-bottom { border-top: 1px solid #1e293b; padding: 1rem 1.5rem; text-align: center; font-size: .8rem; }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="navbar-brand">📚 Subject Management</div>
    <div class="navbar-right">
        <span class="navbar-user">👤 Admin</span>
        <a href="#" class="btn-logout">↩ Logout</a>
    </div>
</nav>
<main>
    <% String msg = (String) request.getAttribute("message");
       if (msg == null) msg = (String) session.getAttribute("message");
       if (msg != null) { session.removeAttribute("message"); %>
        <div class="toast">✅ <%= msg %></div>
    <% } %>
    <div class="page-header"><h2>📚 Subject Management</h2></div>
    <div class="toolbar">
        <form action="${pageContext.request.contextPath}/subject/search" method="get" class="search-form">
            <span style="color:#94a3b8">🔍</span>
            <input type="text" name="q" placeholder="Search by name, category or grade…" value="${keyword}"/>
            <button type="submit">Search</button>
        </form>
        <a href="${pageContext.request.contextPath}/subject/add" class="btn-add">+ Add Subject</a>
    </div>
    <div class="card">
        <table>
            <thead>
                <tr>
                    <th>ID</th><th>Subject Name</th><th>Category</th>
                    <th>Grade Level</th><th>Description</th><th>Status</th><th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <% List<Subject> subjects = (List<Subject>) request.getAttribute("subjects");
               if (subjects == null || subjects.isEmpty()) { %>
                <tr><td colspan="7">
                    <div class="empty">
                        <div class="icon">📭</div>
                        <p>No subjects found. Click <strong>+ Add Subject</strong>!</p>
                    </div>
                </td></tr>
            <% } else { for (Subject s : subjects) {
                   String statusClass = s.getStatus().equalsIgnoreCase("Active") ? "active" : "inactive"; %>
                <tr>
                    <td><code style="color:#0f1f3d;font-size:.8rem;font-weight:600"><%= s.getId() %></code></td>
                    <td><strong><%= s.getSubjectName() %></strong></td>
                    <td><span class="chip"><%= s.getCategory() %></span></td>
                    <td><%= s.getGradeLevel() %></td>
                    <td style="color:#64748b;max-width:180px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap"><%= s.getDescription() %></td>
                    <td><span class="status <%= statusClass %>"><%= s.getStatus() %></span></td>
                    <td>
                        <div class="actions">
                            <a href="${pageContext.request.contextPath}/subject/edit?id=<%= s.getId() %>" class="btn-edit">✏️ Edit</a>
                            <button class="btn-delete" onclick="confirmDelete(<%= s.getId() %>,'<%= s.getSubjectName() %>')">🗑️ Delete</button>
                        </div>
                    </td>
                </tr>
            <% } } %>
            </tbody>
        </table>
    </div>
</main>

<footer>
    <div class="footer-grid">
        <div class="footer-brand">
            <h3>🎓 Tutor Booking</h3>
            <p>This is a academic project developed for<br/>
            <strong style="color:#fff;">SE1020 – OOP Module at SLIIT</strong> by Group WD204</p>
        </div>
        <div class="footer-col">
            <h4>Quick Links</h4>
            <ul>
                <li><a href="#">Dashboard</a></li>
                <li><a href="#">Find Tutors</a></li>
                <li><a href="#">My Bookings</a></li>
                <li><a href="#">Profile</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>Contact Us</h4>
            <p class="address-title">Address</p>
            <p>SLIIT, New Kandy Road, Malabe,<br/>Colombo, Sri Lanka</p>
            <a href="#" class="meet-link">ⓘ Meet at the university premises</a>
        </div>
    </div>
    <div class="footer-bottom">
        <p>© 2026 WD204 | SLIIT | All Rights Reserved</p>
    </div>
</footer>

<div class="modal-overlay" id="deleteModal">
    <div class="modal">
        <h3>🗑️ Delete Subject?</h3>
        <p id="deleteMsg">Are you sure? This cannot be undone.</p>
        <div class="modal-btns">
            <button class="cancel" onclick="closeModal()">Cancel</button>
            <button class="confirm" id="confirmBtn">Yes, Delete</button>
        </div>
    </div>
</div>
<script>
    function confirmDelete(id, name) {
        document.getElementById('deleteMsg').innerHTML = 'Delete <strong>' + name + '</strong>?';
        document.getElementById('confirmBtn').onclick = function() {
            window.location.href = '${pageContext.request.contextPath}/subject/delete?id=' + id;
        };
        document.getElementById('deleteModal').classList.add('show');
    }
    function closeModal() { document.getElementById('deleteModal').classList.remove('show'); }
</script>
</body>
</html>
