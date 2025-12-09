/**
 * @fileoverview    Shift + Click or Ctrl/Alt + Click
 *                  add/remove columns from ORDER BY dynamically
 * @name            columndelete
 */

document.addEventListener('DOMContentLoaded', () => {

    const highlightDuration = 600; // ms for visual feedback

    const handleColumnClick = async (event) => {
        const target = event.target.closest('th.draggable.column_heading.pointer.marker a');
        if (!target) return;

        const th = target.parentElement;
        const orderUrlRemove = th.querySelector('input[name="url-remove-order"]')?.value;
        const orderUrlAdd = th.querySelector('input[name="url-add-order"]')?.value;
        const argsep = CommonParams.get('arg_separator') || '&';

        if (!orderUrlRemove || !orderUrlAdd) return;

        let ajaxUrl = null;

        if (event.ctrlKey || event.altKey) {
            ajaxUrl = `${orderUrlRemove}${argsep}ajax_request=true${argsep}ajax_page_request=true`;
        } else if (event.shiftKey) {
            ajaxUrl = `${orderUrlAdd}${argsep}ajax_request=true${argsep}ajax_page_request=true`;
        } else {
            return; // Normal click, no modifier
        }

        event.preventDefault();

        // Highlight the column temporarily
        th.style.transition = 'background-color 0.3s';
        const originalBg = th.style.backgroundColor;
        th.style.backgroundColor = '#fffa8c'; // light yellow
        setTimeout(() => {
            th.style.backgroundColor = originalBg;
        }, highlightDuration);

        AJAX.source = target;
        Functions.ajaxShowMessage();

        try {
            // Convert query string to URLSearchParams for POST body
            const formData = new URLSearchParams(ajaxUrl);
            const response = await fetch('index.php?route=/sql', {
                method: 'POST',
                body: formData,
            });
            const data = await response.text();
            AJAX.responseHandler(data);
        } catch (err) {
            console.error('AJAX request failed:', err);
        }
    };

    // Delegated event listener: works for dynamically added columns
    document.addEventListener('click', handleColumnClick);

    // Teardown function
    AJAX.registerTeardown('columndelete.js', () => {
        document.removeEventListener('click', handleColumnClick);
    });
});
