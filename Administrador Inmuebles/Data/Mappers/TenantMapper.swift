//
//  TenantMapper.swift
//  Administrador Inmuebles
//
//  Created by Cesar on 19/10/26.
//

struct TenantMapper {
    static func toModel(tenant: Tenant) -> TenantModel {
        TenantModel(id: tenant.id,
                    name: tenant.name,
                    identification: tenant.identification,
                    identification_type: tenant.identification_type,
                    phoneNumber: tenant.phoneNumber,
                    email: tenant.email)
    }
    
    static func toDomain(tenant: TenantModel) -> Tenant {
        Tenant(id: tenant.id,
               name: tenant.name,
               identification: tenant.identification,
               identification_type: tenant.identification_type,
               phoneNumber: tenant.phoneNumber,
               email: tenant.email)
    }
}
