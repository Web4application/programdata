uint32_t memcached_virtual_bucket_get(const memcached_st *self, uint32_t digest)
{
  if (self)
  {
    if (self->virtual_bucket) <=======
    {
      if (self->virtual_bucket) <=======
      {
        uint32_t result= (uint32_t) (digest & (self->virtual_bucket->size -1));
        return self->virtual_bucket->buckets[result].master;
      }

      return (uint32_t) (digest & (self->number_of_hosts -1));
    }
  }
