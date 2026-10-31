# Resize the active split so the shared border moves in the arrow's direction.
# Usage: map alt+shift+right kitten resize.py right
from kittens.tui.handler import result_handler
from kitty.fast_data_types import get_options


def main(args):
    pass


@result_handler(no_ui=True)
def handle_result(args, answer, target_window_id, boss):
    tab = boss.active_tab
    window = boss.window_id_map.get(target_window_id)
    if tab is None or window is None:
        return
    neighbors = tab.current_layout.neighbors_for_window(window, tab.windows)
    opts = get_options()
    direction = args[1]
    if direction in ('left', 'right'):
        grow = bool(neighbors.get('right')) == (direction == 'right')
        tab.resize_window('wider' if grow else 'narrower', opts.window_resize_step_cells)
    else:
        grow = bool(neighbors.get('bottom')) == (direction == 'down')
        tab.resize_window('taller' if grow else 'shorter', opts.window_resize_step_lines)
