</div>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!-- ══════════ FOOTER ══════════ -->
<footer style="margin-left:var(--sidebar-width);background:#0d1b2a;color:rgba(255,255,255,0.6);padding:2rem 1.75rem 1.5rem;border-top:2px solid #00b4d8;transition:margin-left 0.25s ease;" id="footer">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
        <div>
            <div style="color:#fff;font-weight:700;font-size:0.95rem;margin-bottom:3px;">
                <i class="bi bi-mortarboard-fill me-2 text-info"></i>Tutor Booking
            </div>
            <div style="font-size:0.78rem;opacity:0.5;">SE1020 – OOP Module at SLIIT | Group WD204</div>
        </div>
        <div style="font-size:0.78rem;opacity:0.5;">&copy; 2026 WD204 | SLIIT | All Rights Reserved</div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
/* ── Sidebar collapse ── */
const sidebar      = document.getElementById('sidebar');
const mainContent  = document.getElementById('main-content');
const topbar       = document.getElementById('topbar');
const footer       = document.getElementById('footer');
const toggleIcon   = document.getElementById('toggleIcon');

function setSidebar(collapsed) {
    if (collapsed) {
        sidebar.classList.add('collapsed');
        mainContent.classList.add('collapsed');
        topbar.classList.add('collapsed');
        footer.style.marginLeft = 'var(--sidebar-collapsed)';
        toggleIcon.className = 'bi bi-layout-sidebar';
    } else {
        sidebar.classList.remove('collapsed');
        mainContent.classList.remove('collapsed');
        topbar.classList.remove('collapsed');
        footer.style.marginLeft = 'var(--sidebar-width)';
        toggleIcon.className = 'bi bi-layout-sidebar-reverse';
    }
    localStorage.setItem('sidebarCollapsed', collapsed);
}

document.getElementById('sidebarToggle').addEventListener('click', () => {
    setSidebar(!sidebar.classList.contains('collapsed'));
});
document.getElementById('topbarToggle').addEventListener('click', () => {
    setSidebar(!sidebar.classList.contains('collapsed'));
});

// Restore state on load
const saved = localStorage.getItem('sidebarCollapsed');
if (saved === 'true') setSidebar(true);
</script>
