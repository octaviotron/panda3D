from setuptools import setup

setup(
    name='AlfaBetoCeta',
    options={
        'build_apps': {
            'gui_apps': {
                'AlfaBetoCeta': 'index.py',
            },
			'build_base': "../build_alfaBetoCeta",
            'log_filename': 'output.log',
            'log_append': False,
            'include_patterns': [
                '**/*.bam',
				'**/*.wav',
				'**/*.ogg',
				'**/*.ttf'
            ],
            'plugins': [
                'pandagl',
                'p3openal_audio',
            ],
			'platforms': ['manylinux1_x86_64', 'win_amd64'],
			'log_filename' : "log.log"
        }
    }
)
