<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Add Subject – Admin Panel</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: #f0f2f5; font-family: 'Inter', sans-serif; min-height: 100vh; }
        .navbar { background: #0f1f3d; padding: 0 2rem; height: 56px; display: flex; align-items: center; justify-content: space-between; }
        .navbar-brand { color: #fff; font-size: 1rem; font-weight: 600; }
        .navbar-right { display: flex; align-items: center; gap: 1rem; }
        .navbar-user { color: #cbd5e1; font-size: .9rem; }
        .btn-logout { color: #fff; border: 1px solid #fff; background: transparent; padding: .35rem .9rem; border-radius: 6px; font-size: .85rem; text-decoration: none; }

        main { max-width: 750px; margin: 2.5rem auto; padding: 0 1.5rem; }
        .back-link { color: #64748b; text-decoration: none; font-size: .9rem; display: inline-flex; align-items: center; gap: .4rem; margin-bottom: 1.5rem; }
        .back-link:hover { color: #0f1f3d; }

        .card { background: #fff; border: 1px solid #e2e8f0; border-radius: 12px; padding: 2.5rem; }
        .card h2 { font-size: 1.2rem; font-weight: 700; color: #0f1f3d; margin-bottom: .3rem; }
        .card p.sub { color: #64748b; font-size: .88rem; margin-bottom: 2rem; }

        .form-group { margin-bottom: 1.3rem; }
        label { display: block; font-size: .75rem; font-weight: 600; letter-spacing: .6px; text-transform: uppercase; color: #64748b; margin-bottom: .5rem; }
        input[type="text"], select, textarea { width: 100%; background: #f8fafc; border: 1px solid #dde1e7; border-radius: 8px; color: #1e293b; padding: .75rem 1rem; font-size: .9rem; font-family: 'Inter', sans-serif; outline: none; transition: border-color .2s; }
        input:focus, select:focus, textarea:focus { border-color: #0f1f3d; background: #fff; }
        textarea { resize: vertical; min-height: 90px; }
        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
        .btn-row { display: flex; gap: 1rem; margin-top: 1rem; }
        .btn-submit { flex: 1; background: #0f1f3d; color: #fff; border: none; padding: .85rem; border-radius: 8px; font-size: .95rem; font-weight: 600; cursor: pointer; font-family: 'Inter', sans-serif; }
        .btn-submit:hover { background: #1a3260; }
        .btn-cancel { flex: 1; background: #f1f5f9; color: #64748b; border: none; padding: .85rem; border-radius: 8px; font-size: .95rem; font-weight: 600; cursor: pointer; text-decoration: none; text-align: center; font-family: 'Inter', sans-serif; line-height: 1.4; }
        .required { color: #dc2626; }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="navbar-brand">🛡️ Admin Panel</div>
    <div class="navbar-right">
        <span class="navbar-user">👤 Admin</span>
        <a href="#" class="btn-logout">↩ Logout</a>
    </div>
</nav>

<main>
    <a href="${pageContext.request.contextPath}/subject/list" class="back-link">← Back to Subject List</a>
    <div class="card">
        <h2>➕ Add New Subject</h2>
        <p class="sub">Fill in the details below to register a new subject.</p>

        <form action="${pageContext.request.contextPath}/subject/add" method="post">
            <div class="form-group">
                <label>Subject Name <span class="required">*</span></label>
                <input type="text" name="subjectName" placeholder="e.g. Combined Mathematics" required/>
            </div>
            <div class="row">
                <div class="form-group">
                    <label>Category <span class="required">*</span></label>
                    <select name="category" required>
                        <option value="" disabled selected>Select category…</option>
                        <option>Mathematics</option>
                        <option>Science</option>
                        <option>Languages</option>
                        <option>Social Studies</option>
                        <option>ICT</option>
                        <option>Commerce</option>
                        <option>Arts</option>
                        <option>Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Grade Level <span class="required">*</span></label>
                    <select name="gradeLevel" required>
                        <option value="" disabled selected>Select grade…</option>
                        <option>Grade 1-5</option>
                        <option>Grade 6-9</option>
                        <option>Grade 10-11 (O/L)</option>
                        <option>Grade 12-13 (A/L)</option>
                        <option>All Grades</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label>Description</label>
                <textarea name="description" placeholder="Brief description of what this subject covers…"></textarea>
            </div>
            <div class="form-group">
                <label>Status <span class="required">*</span></label>
                <select name="status" required>
                    <option value="Active" selected>Active</option>
                    <option value="Inactive">Inactive</option>
                </select>
            </div>
            <div class="btn-row">
                <a href="${pageContext.request.contextPath}/subject/list" class="btn-cancel">Cancel</a>
                <button type="submit" class="btn-submit">✅ Add Subject</button>
            </div>
        </form>
    </div>
</main>
</body>
</html>
