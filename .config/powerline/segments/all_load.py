# vim:fileencoding=utf-8:noet
from __future__ import (unicode_literals, division, absolute_import, print_function)

from powerline.lib.threaded import ThreadedSegment
from powerline.segments import with_docstring

try:
	import psutil

	class CPULoadPercentSegment(ThreadedSegment):
		interval = 1

		def update(self, old_cpu):
			return psutil.cpu_percent(interval=None)

		def run(self):
			while not self.shutdown_event.is_set():
				try:
					self.update_value = psutil.cpu_percent(interval=self.interval)
				except Exception as e:
					self.exception('Exception while calculating cpu_percent: {0}', str(e))

		def render(self, cpu_percent, format='{0:.0f}%', **kwargs):
			if not cpu_percent:
				return None
			return [{
				'contents': format.format(cpu_percent),
				'gradient_level': cpu_percent,
				'highlight_groups': ['cpu_load_percent_gradient', 'cpu_load_percent'],
			}]
except ImportError:
	class CPULoadPercentSegment(ThreadedSegment):
		interval = 1

		@staticmethod
		def startup(**kwargs):
			pass

		@staticmethod
		def start():
			pass

		@staticmethod
		def shutdown():
			pass

		@staticmethod
		def render(cpu_percent, pl, format='{0:.0f}%', **kwargs):
			pl.warn('Module “psutil” is not installed, thus CPU load is not available')
			return None


cpu_load_percent = with_docstring(CPULoadPercentSegment(),
'''Return the average CPU load as a percentage.

Requires the ``psutil`` module.

:param str format:
	Output format. Accepts measured CPU load as the first argument.

Highlight groups used: ``cpu_load_percent_gradient`` (gradient) or ``cpu_load_percent``.
''')

try:
	import psutil

	class MemLoadPercentSegment(ThreadedSegment):
		def update(self, old_mem):
			mem = psutil.virtual_memory()
			return float(mem.used*100)/float(mem.total)

		def run(self):
			while not self.shutdown_event.is_set():
				try:
					mem = psutil.virtual_memory()
					self.update_value = float(mem.used*100)/float(mem.total)
				except Exception as e:
					self.exception('Exception while calculating mem_percent: {0}', str(e))

		def render(self, mem_percent, format='{0:.0f}%', **kwargs):
			if not mem_percent:
				return None
			return [{
				'contents': format.format(mem_percent),
				'gradient_level': mem_percent,
				'highlight_groups': ['cpu_load_percent_gradient', 'cpu_load_percent'],
			}]
except ImportError:
	class MemLoadPercentSegment(ThreadedSegment):
		@staticmethod
		def startup(**kwargs):
			pass

		@staticmethod
		def start():
			pass

		@staticmethod
		def shutdown():
			pass

		@staticmethod
		def render(mem_percent, pl, format='{0:.0f}%', **kwargs):
			pl.warn('Module “psutil” is not installed, thus Mem load is not available')
			return None


mem_load_percent = with_docstring(MemLoadPercentSegment(),
'''Return the average Mem load as a percentage.

Requires the ``psutil`` module.

:param str format:
	Output format. Accepts measured Mem load as the first argument.

Highlight groups used: ``mem_load_percent_gradient`` (gradient) or ``mem_load_percent``.
''')
