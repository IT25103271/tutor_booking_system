<%@ page contentType="text/html; charset=UTF-8" language="java" %>
</div>
<!-- ══════════ FOOTER ══════════ -->
<footer style="margin-left:var(--sidebar-width);background:linear-gradient(90deg, #4f6ef7 0%, #3d5ce5 100%);color:rgba(255,255,255,0.85);padding:1.2rem 1.75rem;border-top:3px solid #38bdf8;transition:margin-left 0.25s ease;position:relative;clear:both;" id="footer">
  <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
    <div>
      <div style="color:#fff;font-weight:700;font-size:0.85rem;margin-bottom:2px;">
        <i class="bi bi-mortarboard-fill me-2" style="color:#fff;"></i>Tutor Booking
      </div>
      <div style="font-size:0.7rem;opacity:0.7;">SE1020 – OOP Module at SLIIT | Group WD204</div>
    </div>
    <div class="d-flex flex-wrap gap-3 align-items-center" style="font-size:0.75rem;">
      <a href="${pageContext.request.contextPath}/student/dashboard" style="color:rgba(255,255,255,0.85);text-decoration:none;transition:color 0.2s;" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='rgba(255,255,255,0.85)'">Dashboard</a>
      <a href="${pageContext.request.contextPath}/student/view-subjects" style="color:rgba(255,255,255,0.85);text-decoration:none;transition:color 0.2s;" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='rgba(255,255,255,0.85)'">Subjects</a>
      <a href="${pageContext.request.contextPath}/student/view-tutors" style="color:rgba(255,255,255,0.85);text-decoration:none;transition:color 0.2s;" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='rgba(255,255,255,0.85)'">Tutors</a>
      <a href="${pageContext.request.contextPath}/student/my-bookings" style="color:rgba(255,255,255,0.85);text-decoration:none;transition:color 0.2s;" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='rgba(255,255,255,0.85)'">My Bookings</a>
      <a href="${pageContext.request.contextPath}/student/profile" style="color:rgba(255,255,255,0.85);text-decoration:none;transition:color 0.2s;" onmouseover="this.style.color='#fff'" onmouseout="this.style.color='rgba(255,255,255,0.85)'">Profile</a>
    </div>
    <div style="font-size:0.7rem;opacity:0.7;">&copy; 2026 WD204 | SLIIT</div>
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
      if (toggleIcon) toggleIcon.className = 'bi bi-layout-sidebar';
    } else {
      sidebar.classList.remove('collapsed');
      mainContent.classList.remove('collapsed');
      topbar.classList.remove('collapsed');
      footer.style.marginLeft = 'var(--sidebar-width)';
      if (toggleIcon) toggleIcon.className = 'bi bi-layout-sidebar-reverse';
    }
    localStorage.setItem('sidebarCollapsed', collapsed);
  }

  document.getElementById('sidebarToggle').addEventListener('click', () => {
    setSidebar(!sidebar.classList.contains('collapsed'));
  });

  // Restore state on load
  const saved = localStorage.getItem('sidebarCollapsed');
  if (saved === 'true') setSidebar(true);
</script>
</body>
</html>