using Bakeries.DataAccess.Entities;

namespace Bakeries.DataAccess
{
    internal static class clsExtensions
    {
        public static IQueryable<T> WhereNotDeleted<T>(this IQueryable<T> queryable) where T : clsBaseEntities
        {
            return queryable.Where(e => e.DeletedAt == null);
        }
    }
}
