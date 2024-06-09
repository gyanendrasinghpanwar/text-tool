from setuptools import setup, find_packages

setup(
    name='text-tool',
    version='0.1',
    packages=find_packages(),
    entry_points={
        'console_scripts': [
            'text-tool=text_tool.main:main',
        ],
    },
    install_requires=[],
    description='A CLI tool for text processing',
    author='Gyanendra singh',
    author_email='gyanendrapanwar371@gmail.com',
    url='https://github.com/gyanendrasinghpanwar/text-tool',
)
