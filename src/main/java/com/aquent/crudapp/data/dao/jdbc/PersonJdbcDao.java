package com.aquent.crudapp.data.dao.jdbc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.aquent.crudapp.data.dao.PersonDao;
import com.aquent.crudapp.domain.Person;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;

/**
 * Spring JDBC implementation of {@link PersonDao}.
 */
public class PersonJdbcDao implements PersonDao {

    private static final String SQL_LIST_PEOPLE = "SELECT * FROM person ORDER BY first_name, last_name, person_id";
    private static final String SQL_LIST_PEOPLE_FOR_CLIENT = "SELECT * FROM person WHERE client_id = :clientId ORDER BY first_name, last_name, person_id";
    private static final String SQL_READ_PERSON = "SELECT * FROM person WHERE person_id = :personId";
    private static final String SQL_DELETE_PERSON = "DELETE FROM person WHERE person_id = :personId";
    private static final String SQL_UPDATE_PERSON = "UPDATE person SET (first_name, last_name, email_address, street_address, city, state, zip_code, client_id)"
                                                  + " = (:firstName, :lastName, :emailAddress, :streetAddress, :city, :state, :zipCode, :clientId)"
                                                  + " WHERE person_id = :personId";
    private static final String SQL_CREATE_PERSON = "INSERT INTO person (first_name, last_name, email_address, street_address, city, state, zip_code, client_id)"
                                                  + " VALUES (:firstName, :lastName, :emailAddress, :streetAddress, :city, :state, :zipCode, :clientId)";

    private static final String SQL_UPDATE_CLIENT_FOR_PERSONS = "UPDATE person SET client_id = :clientId WHERE person_id IN (:personIdList)";
	
	
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    public void setNamedParameterJdbcTemplate(NamedParameterJdbcTemplate namedParameterJdbcTemplate) {
        this.namedParameterJdbcTemplate = namedParameterJdbcTemplate;
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public List<Person> listPeople() {
        return namedParameterJdbcTemplate.getJdbcOperations().query(SQL_LIST_PEOPLE, new PersonRowMapper());
    }
	
    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public List<Person> listPeopleByClient(Integer clientId)
		{
		return namedParameterJdbcTemplate.query(SQL_LIST_PEOPLE_FOR_CLIENT, Collections.singletonMap("clientId", clientId), new PersonRowMapper());
		}

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = false)
	public void syncPeopleForClient( Integer clientId, List<Integer> selectedPersonIdList)
		{
		Set<Integer>removedPersonIDsSet = new HashSet<>();
		Set<Integer>addedPersonIDsSet = new HashSet<>();
		
		// get everybody
		List<Person>allPersonsList = listPeople();

		// populate 'removedPersons' AND addedPersons lists
		for (Person current : allPersonsList)
			{
			if( current.getClientId().equals(clientId))
				{
				// This person is the correct client.  See if it needs to be removed.
				// if not in the new selected list then put into the removed list.
				if( selectedPersonIdList.contains( current.getPersonId()) == false)
					removedPersonIDsSet.add( current.getPersonId());
				}
			else
				{
				// this person is NOT the correct client. See if it needs to be added.
				// if it IS in the new selected list, then add it.
				if(selectedPersonIdList.contains( current.getPersonId()) )
					addedPersonIDsSet.add( current.getPersonId());
				}
			}

		// update all that need updaig to -1 (None)
		if( removedPersonIDsSet.isEmpty() == false )
			{
			MapSqlParameterSource parameters = new MapSqlParameterSource();
			parameters.addValue("personIdList", removedPersonIDsSet);
			parameters.addValue("clientId", -1 );
			namedParameterJdbcTemplate.update(SQL_UPDATE_CLIENT_FOR_PERSONS, parameters);
			}
		
		// update all that need updating to this clientId.
		if( addedPersonIDsSet.isEmpty() == false )
			{
			MapSqlParameterSource parameters = new MapSqlParameterSource();
			parameters.addValue("personIdList", addedPersonIDsSet);
			parameters.addValue("clientId", clientId);
			namedParameterJdbcTemplate.update(SQL_UPDATE_CLIENT_FOR_PERSONS, parameters);
			}
		}

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public Person readPerson(Integer personId) {
        return namedParameterJdbcTemplate.queryForObject(SQL_READ_PERSON, Collections.singletonMap("personId", personId), new PersonRowMapper());
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = false)
    public void deletePerson(Integer personId) {
        namedParameterJdbcTemplate.update(SQL_DELETE_PERSON, Collections.singletonMap("personId", personId));
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = false)
    public void updatePerson(Person person) {
        namedParameterJdbcTemplate.update(SQL_UPDATE_PERSON, new BeanPropertySqlParameterSource(person));
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = false)
    public Integer createPerson(Person person) {
        KeyHolder keyHolder = new GeneratedKeyHolder();
        namedParameterJdbcTemplate.update(SQL_CREATE_PERSON, new BeanPropertySqlParameterSource(person), keyHolder);
        return keyHolder.getKey().intValue();
    }

    /**
     * Row mapper for person records.
     */
    private static final class PersonRowMapper implements RowMapper<Person> {

        @Override
        public Person mapRow(ResultSet rs, int rowNum) throws SQLException {
            Person person = new Person();
            person.setPersonId(rs.getInt("person_id"));
            person.setFirstName(rs.getString("first_name"));
            person.setLastName(rs.getString("last_name"));
            person.setEmailAddress(rs.getString("email_address"));
            person.setStreetAddress(rs.getString("street_address"));
            person.setCity(rs.getString("city"));
            person.setState(rs.getString("state"));
            person.setZipCode(rs.getString("zip_code"));
			person.setClientId(rs.getInt("client_id"));
            return person;
        }
    }
}
