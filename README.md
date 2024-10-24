# hackycracky

*crackin away cause I'm hackin all day, these rhymes may be gay but they're here anwyay*

repository to maintain a consistent environment throughout various hackycracky machines

current method of deploying environment:

```
rm ~/.bashrc
if [ -d ~/.bash ]; then
    rm -r ~/.bash
fi
sync/symbolic.sh
```
